Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: "search#show"
      end
      resources :items, only: [:index, :show]
    end
  end
end
