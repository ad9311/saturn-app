Rails.application.routes.draw do
  root 'dashboard#index'

  # Devise
  devise_for :users, skip: [:registrations]

  # Users
  get 'users/account', to: 'users#account'

  # Dashboard
  resources :dashboard, only: %i[index]

  # Thoughts
  get 'thoughts/favorites', to: 'thoughts#favorites'
  patch 'thoughts/:id/bookmark', to: 'thoughts#bookmark'
  patch 'thoughts/:id/unbookmark', to: 'thoughts#unbookmark'
  delete 'thoughts/all', to: 'thoughts#destroy_all'
  resources :thoughts, only: %i[index new edit create destroy update]

  # Recoveries
  get 'recoveries/favorites', to: 'recoveries#favorites'
  delete 'recoveries/all', to: 'recoveries#destroy_all'
  resources :recoveries
  patch 'recoveries/:id/report', to: 'recoveries#submit_report'
  get 'recoveries/:id/renew', to: 'recoveries#renew'
  patch 'recoveries/:id/renew', to: 'recoveries#submit_renew'
  patch 'recoveries/:id/bookmark', to: 'recoveries#bookmark'
  patch 'recoveries/:id/unbookmark', to: 'recoveries#unbookmark'

  # Stoppers
  resources :recoveries do
    resources :stoppers, only: %i[index new create]
  end

  # Routines
  get 'routines/favorites', to: 'routines#favorites'
  delete 'routines/all', to: 'routines#destroy_all'
  resources :routines
  patch 'routines/:id/report', to: 'routines#submit_report'
  patch 'routines/:id/setback', to: 'routines#submit_setback'
  patch 'routines/:id/bookmark', to: 'routines#bookmark'
  patch 'routines/:id/unbookmark', to: 'routines#unbookmark'
  get 'routines/:id/new_target', to: 'routines#new_target'
  patch 'routines/:id/submit_new_target', to: 'routines#submit_new_target'

  # Reminders
  delete 'reminders/all', to: 'reminders#destroy_all'
  resources :reminders

  # Budgets
  resources :budgets

  # Expenses
  resources :budgets do
    resources :expenses, except: %i[index]
  end
end
