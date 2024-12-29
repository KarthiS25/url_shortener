Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :urls, only: [:create, :index] do
        collection do
          get ':short_url', to: 'urls#show'
        end
      end
    end
  end
end
