Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  resources :bank_accounts, except: [:destroy, :edit, :update]

  resources :users do
    resources :bank_accounts, controller: "users/bank_accounts" # except: [:index, :show, :destroy]
  end

  namespace :api do
    namespace :v1 do
      post "bank_accounts/new_transaction", to: "bank_accounts#new_transaction"
    end
  end
end
