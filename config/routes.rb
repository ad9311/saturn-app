Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Devise
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # Api
  namespace :api do
    # Users
    resources :users, only: [] do
      collection do
        get 'me', to: 'users#me'
      end
    end

    # Budget Periods
    resources :budgets, param: :uid, only: %i[index show] do
      collection do
        get 'last', to: 'budgets#show_last'
      end
      resources :incomes, only: %i[create]
      resources :expenses, only: %i[create]
    end

    resources :expense_categories, only: %i[index create]
  end
end
