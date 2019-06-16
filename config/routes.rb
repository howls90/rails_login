Rails.application.routes.draw do
  root 'sessions#new'

  resources :users, only: [:new, :create , :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update], param: :token

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  # Rescue from errors
  match '*unmatched_route', :to => 'application#raise_not_found!', :via => :all
end
