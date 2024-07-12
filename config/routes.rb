Rails.application.routes.draw do
  # Root path
  root to: 'home#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Devise
  devise_for :users, path: 'api', controllers: { sessions: 'users/sessions' }

  # Api
  namespace :api do
    # Users
    resources :users, only: [] do
      collection do
        get 'me', to: 'users#me'
      end
    end

    # Budget Periods
    resources :budget_periods, only: %i[index]
  end

  # Users
  get 'account/destroy', to: 'users#confirm_destroy', as: :confirm_destroy_user
  delete 'account/destroy', to: 'users#destroy', as: :destroy_user

  # Settings
  resources :settings, only: :index do
    collection do
      patch 'locale', to: 'settings#update_locale'
    end
  end

  # Home
  resources :home, only: %i[index]

  # Budget periods
  resources :budget_periods, path: :budgets, param: :uid, only: %i[index show]
  get 'budgets/:uid/details', to: 'budget_periods#details', as: :budget_period_details

  # Income transactions
  resources :budgets, only: [], param: :uid do
    resources :income_transactions, path: :income, except: %i[index show]
    resources :expense_transactions, path: :expense, except: %i[index show]
    get 'expenses/categories_chart', to: 'expense_transactions#categories_chart'
  end

  # Expense categories
  resources :expense_categories, except: :show

  # Todo Lists
  resources :todo_lists do
    resources :todo_tasks, only: %i[new create edit update destroy]
    resources :todo_categories, except: :show
  end
end
