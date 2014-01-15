module TweetsHelper

  # Fetch +count+ tweets randomly from the 20 cached last favorite tweets, sorted by date desc
  def random_favorite_tweets(count = 3)
    cached_last_favorite_tweets(20).sample(count).sort_by { |t| t.created_at }.reverse
  end

  # Fetch +count+ last favorite tweets and cache the array for 1 hour
  def cached_last_favorite_tweets(count)
    Rails.cache.fetch "what_people_say_#{count}", expires_in: 5.minutes do
      TwitterWrapper.pretty_favorites(
        count: count,
        since_date: Time.utc(2011, 3, 29)
      )
    end
  end

  def clean_tweet_text(tweet)
    tweet_text = tweet.text
    tweet_text = tweet_text.gsub(/(\s?\/\s*cc\s\@\w+)/, '')
    tweet_text = tweet_text.gsub(/\s*[:-]\s*$/, '')
    tweet_text = tweet_text.gsub(%r{https?://\S+(\s|$)}, ' ')

    tweet_text.strip
  end

  def clean_tweet_from_user(tweet)
    tweet.user.name.titleize
  end

end
