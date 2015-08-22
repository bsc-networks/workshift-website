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
    post 'settings/preferences/schedule' => :update_schedule,
         as: :update_schedule
    post 'residents/:id/settings/quiet_hours' => :update_quiet_hours,
         as: :update_quiet_hours
    post 'residents/:id/settings/required_hours' => :update_required_hours,
         as: :update_required_hours
    post 'residents/:id/settings/workshift_selling_limit' => :update_workshift_selling_limit,
         as: :update_workshift_selling_limit
    get 'residents/reports' => :reports, as: :reports
    get 'residents/reports/semester' => :view_semester_report,
        as: :view_semester_report
    get 'residents/reports/:id' => :view_report, as: :view_report
    get 'residents/reports/semester/download' => :download_semester_report,
        as: :download_semester_report
    get 'residents/reports/:id/download' => :download_report,
        as: :download_report
  end

  scope controller: :standalone_workshift_signoff do
    get 'signoff' => :index
    post 'signoff' => :load_user, as: :load_user
  end

  scope controller: :workshift_assignments do
    get 'workshifts/marketplace' => :marketplace_index, as: :marketplace
    post 'workshift_assignments/:id/check_off' => :check_off,
         as: :assignment_check_off
    post 'workshift_assignments/:id/sell_to/:buyer_id' => :sell_to,
         as: :assignment_sell_to
    post 'workshift_assignments/:id/undo_sell/' => :undo_sell,
         as: :assignment_undo_sell
    post 'workshift_assignments/:id/sell' => :put_on_market,
         as: :put_on_market
  end

  devise_for :users
  devise_scope :user do
    get 'login' => 'devise/sessions#new', as: :login
    get 'settings' => 'devise/registrations#edit', as: :settings
    get 'logout' => 'devise/sessions#destroy', as: :logout
    get 'register' => 'devise/registrations#new', as: :register
    get 'residents/add' => 'devise/invitations#new', as: :add_users
    get 'setpw', to: 'devise/invitations#edit', as: :setpw
  end

  resources :categories, path: 'workshifts/categories'
  resources :workshifts
end
