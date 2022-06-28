Rails.application.routes.draw do
  devise_for :users
  resources :groups, only: %i[index new create], path: '/categories'
  resources :budget_transactions, only: %i[index new create], path: 'transactions'

  root 'groups#index'
end
