Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:show, :index], controller: "merchants/merchants" do
        collection do
          get 'find', to: 'merchants/find#show'
          get 'find_all', to: 'merchants/find#index'
          get 'random', to: 'merchants/random#show'
        end
      end
      resources :customers, only: [:show, :index], controller: "customers/customers" do
        collection do
          get 'find', to: 'customers/find#show'
          get 'find_all', to: 'customers/find#index'
          get 'random', to: 'customers/random#show'
        end
      end
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end
      resources :items, only: [:index, :show]
      resources :invoices, only: [:show, :index], controller: "invoices/invoices" do
        collection do
          get 'find', to: 'invoices/search#show'
          get 'find_all', to: 'invoices/search#index'
          get 'random', to: 'invoices/random#show'
        end
      end
    end
  end
end
