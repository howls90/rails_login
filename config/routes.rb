Rails.application.routes.draw do
  root 'sessions#new'

  resources :users, only: [:new, :create , :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
