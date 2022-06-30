Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: %i[index], path: '/profile'
  resources :groups, only: %i[index new create], path: '/categories' do
    resources :budget_transactions, only: %i[index new create], path: '/transactions'  
  end

  root 'groups#index'
end
