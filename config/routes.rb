Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:show, :index], :controller => "merchants/merchants" do
        collection do
          get 'find', to: 'merchants/find#show'
          get 'find_all', to: 'merchants/find#index'
          get 'random', to: 'merchants/random#show'
        end
      end
    end
  end
end
