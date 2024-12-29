Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :urls, only: [:create, :index]
      get '/:short_url', to: 'urls#show'
    end
  end
end
