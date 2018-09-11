TestApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "twitter_feeds", to: 'twitters#twitter_feeds'
    end
  end
end
