Rails.application.routes.draw do
  root to: 'home#index'
  resources :bank_accounts, only: [:index, :show]
end
