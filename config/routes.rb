Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:show, :index], controller: "merchants/merchants" do
        get 'revenue', to: 'merchants/revenue#show'
        collection do
          get ':id/items', to: 'merchants/items#index'
          get ':id/invoices', to: 'merchants/invoices#index'
          get 'find',     to: 'merchants/find#show'
          get 'find_all', to: 'merchants/find#index'
          get 'random',   to: 'merchants/random#show'
          #business intelligence
          get ':id/revenue',    to: 'merchants/revenue#show'
          get 'most_items', to: 'merchants/most_items#index'
          get ':id/favorite_customer', to: 'merchants/favorite_customer#show'
          get 'most_revenue', to: 'merchants/most_revenue#index'
          get 'revenue', to: 'merchants/revenue_by_date#index'
          get ':id/customers_with_pending_invoices', to: 'merchants/customers_with_pending_invoices#index'
        end
      end
      resources :customers, only: [:show, :index], controller: "customers/customers" do
        collection do
          get ':id/invoices', to: 'customers/invoices#index'
          get ':id/transactions', to: 'customers/transactions#index'
          get 'find',     to: 'customers/find#show'
          get 'find_all', to: 'customers/find#index'
          get 'random',   to: 'customers/random#show'
          #business intelligence
          get ':id/favorite_merchant', to: 'customers/favorite_merchant#show'
        end
      end
      resources :transactions, only: [:show, :index], controller: "transactions/transactions" do
        collection do
          get ':id/invoice', to: 'transactions/invoices#show'
          get 'find',     to: 'transactions/find#show'
          get 'find_all', to: 'transactions/find#index'
          get 'random',   to: 'transactions/random#show'
        end
      end
      resources :items, only: [:show, :index], controller: "items/items" do
        collection do
          get 'find',     to: 'items/search#show'
          get 'find_all', to: 'items/search#index'
          get 'random',   to: 'items/random#show'
          #relationships
          get ':id/invoice_items', to: 'items/invoice_items#index'
          get ':id/merchant',      to: 'items/merchant#show'
          #business intelligence
          get 'most_items',    to: 'items/most_items#index'
          get 'most_revenue', to: 'items/most_revenue#index'
          get ':id/best_day', to: 'items/best_day#show'
        end
      end
      resources :invoices, only: [:show, :index], controller: "invoices/invoices" do
        collection do
          get 'find',     to: 'invoices/search#show'
          get 'find_all', to: 'invoices/search#index'
          get 'random',   to: 'invoices/random#show'
          #relationships
          get ':id/transactions',  to: 'invoices/transactions#index'
          get ':id/invoice_items', to: 'invoices/invoice_items#index'
          get ':id/items',         to: 'invoices/items#index'
          get ':id/customer',      to: 'invoices/customer#show'
          get ':id/merchant',      to: 'invoices/merchant#show'
        end

      end
      resources :invoice_items, only: [:show, :index], controller: "invoice_items/invoice_items" do
        collection do
          get 'find',     to: 'invoice_items/search#show'
          get 'find_all', to: 'invoice_items/search#index'
          get 'random',   to: 'invoice_items/random#show'
          #relationships
          get ':id/invoice', to: 'invoice_items/invoice#show'
          get ':id/item',    to: 'invoice_items/item#show'
        end
      end
    end
  end
end
