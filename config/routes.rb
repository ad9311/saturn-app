Rails.application.routes.draw do
  # Root path
  root to: 'home#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Devise
  devise_for :users

  # Home
  resources :home, only: %i[index]

  # Budget periods
  get 'budgets', to: 'budget_periods#index'
  get 'budgets/:uid', to: 'budget_periods#show'
  get 'budgets/:uid/details', to: 'budget_periods#details'

  # Income transactions
  resources :budgets, param: :uid do
    get 'income/new', to: 'income_transactions#new'
    post 'income', to: 'income_transactions#create'
    get 'income/:id/edit', to: 'income_transactions#edit'
    patch 'income/:id', to: 'income_transactions#update'
  end
end
