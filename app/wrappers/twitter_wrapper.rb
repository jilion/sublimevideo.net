module TwitterWrapper
  include Configurator

  config_file 'twitter.yml'
  config_accessor :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret

  class << self

    def remote_favorites(user, options={})
      favorites(user, page: options[:page], include_entities: options[:include_entities])
    end

    # Return a certain number of random favorites tweets of a user, ordered by date desc FROM Twitter.
    #
    # Options:
    # - user: a Twitter username (default: 'sublimevideo')
    # - user_doublon: if you allow more than 1 tweet by the same user (default: true)
    # - count: number of favorites to return (default: 0)
    # - random: if you want to return tweets randomly (default: false)
    # - since_date: return favorites only after since_date (default: nil)
    # - include_entities: wether to include entities in results or not (default: false)
    def pretty_remote_favorites(*args)
      options = args.extract_options!
      options.assert_valid_keys([:user_doublon, :count, :random, :since_date, :include_entities])
      options = options.reverse_merge({
        user: 'sublimevideo',
        user_doublon: true,
        count: 0,
        random: false,
        since_date: nil,
        include_entities: false
      })

      page = 1
      tweets = []

      while favorites = remote_favorites(options[:user], page: page, include_entities: options[:include_entities])
        break if favorites.blank?
        favorites.each do |tweet|
          break if options[:since_date] && tweet.created_at < options[:since_date]
          tweets << tweet
        end
        page += 1
      end

      count = if options[:count] == 0
        tweets.size
      else
        [(options[:user_doublon] ? tweets.size : tweets.map { |tweet| tweet.user.id }.uniq.size), options[:count]].min
      end

      selected_tweets = options[:random] ? [] : tweets
      if options[:random]
        while selected_tweets.size < count
          t = tweets.sample
          selected_tweets << t if options[:user_doublon] || selected_tweets.map { |tweet| tweet.user.id }.exclude?(t.user.id)
        end
      end

      selected_tweets.sort { |a, b| b.created_at <=> a.created_at }[0...count]
    end

    def method_missing(method_name, *args)
      method_name = method_name.to_sym

      if Twitter.respond_to?(method_name)
        begin
          with_rescue_and_retry(3) do
            Twitter.send(method_name, *args)
          end
        rescue => ex
          # Notify.send("Exception during call to Twitter: #{ex.message}", exception: ex)
          nil
        end
      else
        super
      end
    end

    def respond_to?(method_name)
      method_name = method_name.to_sym

      Twitter.respond_to?(method_name) || super
    end

    def with_rescue_and_retry(times)
      rescue_and_retry(times, Errno::ETIMEDOUT, Errno::ECONNRESET, Twitter::Error::BadGateway, Twitter::Error::ServiceUnavailable, Twitter::Error::InternalServerError) do
        yield
      end
    end

  end

end
