require 'rescue_me'
require 'twitter'

module TwitterWrapper

  # Return a certain number of random favorites tweets of a user, ordered by date desc FROM Twitter.
  #
  # Options:
  # - user: a Twitter username (default: 'sublimevideo')
  # - user_doublon: if you allow more than 1 tweet by the same user (default: true)
  # - count: number of favorites to return (default: 0)
  # - random: if you want to return tweets randomly (default: false)
  # - since_date: return favorites only after since_date (default: nil)
  # - include_entities: wether to include entities in results or not (default: false)
  def self.pretty_favorites(*args)
    options = {
      user: 'sublimevideo',
      user_doublon: true,
      count: 0,
      random: false,
      since_date: nil,
      include_entities: false
      }.merge(args.extract_options!)
    options.assert_valid_keys([:user, :user_doublon, :count, :random, :since_date, :include_entities])

    tweets = _all_favorites(options)

    count = if options[:count].zero?
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

  def self.method_missing(method_name, *args)
    method_name = method_name.to_sym

    if Twitter.respond_to?(method_name)
      begin
        _with_rescue_and_retry(3) do
          Twitter.send(method_name, *args)
        end
      rescue => ex
        nil
      end
    else
      super
    end
  end

  def self.respond_to?(method_name)
    method_name = method_name.to_sym

    Twitter.respond_to?(method_name) || super
  end

  private

  def self._favorites(user, options)
    favorites(user, page: options[:page], include_entities: options[:include_entities])
  end

  def self._all_favorites(options)
    page, user, tweets = 1, options.delete(:user), []

    while favorites = _favorites(user, options.merge(page: page))
      break if favorites.blank?

      favorites.each do |tweet|
        break if options[:since_date] && tweet.created_at < options[:since_date]

        tweets << tweet
      end
      page += 1
    end

    tweets
  end

  def self._with_rescue_and_retry(times)
    rescue_and_retry(times, Errno::ETIMEDOUT, Errno::ECONNRESET, Twitter::Error::BadGateway, Twitter::Error::ServiceUnavailable, Twitter::Error::InternalServerError) do
      yield
    end
  end

end
