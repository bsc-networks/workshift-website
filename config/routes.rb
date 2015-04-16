WorkshiftWebsite::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes"

  root to: 'users#profile'

  scope controller: :users do
    get 'profile/:id' => :profile, as: :user_profile
    get 'residents' => :index, as: :roster
    get 'settings/preferences' => :preferences, as: :preferences
    delete 'residents/delete/all' => :delete_all, as: :delete_all_users
    post 'residents/add' => :add_users, as: :invite_users
    post 'settings/preferences/categories' => :update_category_preferences,
         as: :update_category_preferences
    get 'residents/reports' => :reports, as: :reports
    get 'residents/reports/:id' => :view_report, as: :view_report
    get 'residents/reports/:id/download' => :download_report,
        as: :download_report
  end
  get 'workshift_assignments/marketplace' => 'workshift_assignments#marketplace_index', as: :marketplace
  post 'workshift_assignments/:id/check_off' => 'workshift_assignments#check_off', as: :assignment_check_off
  post 'workshift_assignments/:id/sell_to/:buyer_id' => 'workshift_assignments#sell_to', as: :assignment_sell_to
  post 'workshift_assignments/:id/sell' => 'workshift_assignments#put_on_market', as: :put_on_market
  
  devise_for :users
  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :login
    get 'settings' => 'devise/registrations#edit', as: :settings
    get 'logout' => 'devise/sessions#destroy', as: :logout
    get 'register' => 'devise/registrations#new', as: :register
    get 'residents/add' => 'devise/invitations#new', as: :add_users
    get 'setpw', to: 'devise/invitations#edit', as: :setpw
  end

  resources :workshifts
  resources :categories
end
