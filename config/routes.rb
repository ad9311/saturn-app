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
  get 'budgets/:uid', to: 'budget_periods#show', as: :budget
  get 'budgets/:uid/details', to: 'budget_periods#details', as: :budget_details

  # Income transactions
  resources :budgets, only: [], param: :uid do
    resources :income_transactions, path: :income, only: %i[new edit create update]
  end
end
