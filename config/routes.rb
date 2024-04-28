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
  resources :budget_periods, path: :budgets, param: :uid, only: %i[index show]
  get 'budgets/:uid/details', to: 'budget_periods#details', as: :budget_period_details

  # get 'budgets', to: 'budget_periods#index'
  # get 'budgets/:uid', to: 'budget_periods#show', as: :budget

  # Income transactions
  resources :budgets, only: [], param: :uid do
    resources :income_transactions, path: :income, except: %i[index show]
    resources :expense_transactions, path: :expense, except: %i[index show]
  end

  # Expense categories
  resources :expense_categories, except: :show
end
