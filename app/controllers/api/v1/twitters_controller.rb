class Api::V1::TwittersController < ApplicationController

  def twitter_init
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = params[:consumer_key] || "uJ6LD4ah9ghUpcakMSSkqcw7N"
      config.consumer_secret     = params[:consumer_secret] || "QcyvGVv2oBYkvztetLf1ip21R6J1aMqOlsd5hvuoft1HDtVw8f"
      config.access_token        = params[:access_token] || "4834942060-ZH4hsRUIlkNyxeIg1BVSGQL6wLL1nFdyfVovNWs"
      config.access_token_secret = params[:access_token_secret] || "50eRVI7Bi9ewE3j7sJV4KEgPAu89ExNGlNMAUFGCqbv9o"
    end
  end

  def twitter_feeds
    twitter_init
    tweets = @client.home_timeline
    render json: { tweets: tweets_data(tweets), status: 200 }
  end

  def tweets_data(tweets)
    data = []
    if params[:start_date].present? && params[:end_date].present?
      tweets.each do |tweet|
        if tweet.created_at.to_date >= params[:start_date].to_date && tweet.created_at.to_date <= params[:end_date].to_date
          data << { "tweet data" => tweet.full_text, "tweet date" => tweet.created_at }
        end
      end
    else
      tweets.each do |tweet|
        data << { "tweet data" => tweet.full_text, "tweet date" => tweet.created_at }
      end        
    end
    data
  end
end

