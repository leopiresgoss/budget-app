require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: %i[index], path: '/profile'
  resources :groups, only: %i[index new create], path: '/categories' do
    resources :budget_transactions, only: %i[index new create], path: '/transactions'  
  end
  mount Sidekiq::Web => '/sidekiq'
  get '/add-money', to: 'users#add_money_view', as: 'add_money_view'
  patch '/add-money', to: 'users#add_money', as: 'add_money'

  root 'groups#index'
end
