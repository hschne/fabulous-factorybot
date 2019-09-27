Rails.application.routes.draw do
  root 'home#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions, only: %i[create]
  resources :users
  resources :projects, shallow: true do
    resources :notes
    resources :memberships, only: %i[index new create destroy]
  end
end
