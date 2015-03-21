WorkshiftWebsite::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes"

  root to: 'users#profile'

  get 'profile/:id' => 'users#profile', as: 'user_profile'
  get 'roster' => 'users#index', as: 'roster'
  post 'users/add' => 'users#add_users', as: :invite_users
  delete 'users/delete/all' => 'users#delete_all', as: :delete_all_users

  devise_for :users
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :login
    get 'settings', to: 'devise/registrations#edit', as: :settings
    get 'logout', to: 'devise/sessions#destroy', as: :logout
    get 'register', to: 'devise/registrations#new', as: :register
    get 'users/add', to: 'devise/invitations#new', as: :add_users
    get 'setpw', to: 'devise/invitations#edit', as: :setpw
  end

  resources :workshifts
  resources :categories
end
