require 'twitter'

class WeatherBot
  def tweet_forecast
    twitter_client.update '今日は晴れです'
  rescue => e
    notify
  end

  def twitter_client
    Twitter::REST::Client.new
  end

  def notify
    # （エラーの通知を行う。実装は省略）
  end
end
