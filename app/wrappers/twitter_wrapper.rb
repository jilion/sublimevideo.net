require 'rescue_me'
require 'twitter'

module TwitterWrapper

  # Return a certain number of random favorites tweets of a user, ordered by date desc FROM Twitter.
  #
  # Options:
  # - since_date: return favorites only after since_date (default: nil)
  def self.pretty_favorites(opts = {})
    options = { since_date: nil, count: 10 }.merge(opts)

    tweets = _random_tweets(_sublimevideo_favorites(options), options[:count])

    tweets.sort { |a, b| b.created_at <=> a.created_at }[0...options[:count]]
  end

  private

  def self._random_tweets(tweets, count)
    selected_tweets, i = [], 0
    while i < tweets.size
      tweet = tweets.sample
      selected_tweets << tweet if selected_tweets.map { |tweet| tweet.user.id }.exclude?(tweet.user.id)
      i += 1
    end

    selected_tweets
  end

  def self._favorites(user, page)
    client.favorites(user, count: 200, page: page, include_entities: true)
  rescue Twitter::Error::TooManyRequests => ex
    raise ex if Rails.env.development?
    nil
  end

  def self._sublimevideo_favorites(options = {})
    page, tweets = 1, []

    while favorites = _favorites('sublimevideo', page)
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

  def self.client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
      config.oauth_token        = ENV['TWITTER_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
    end
  end

end
