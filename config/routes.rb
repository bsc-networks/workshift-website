Rails.application.routes.draw do


  resources :shifts
  resources :metashifts
  root to: 'workshift#index'
  get '/users/get_all' => 'users#get_all', as: 'get_all_users'

  resources :users do
    collection { post :import }
  end
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/login2' => 'sessions#test'
  get '/logout' => 'sessions#destroy'
  #get  'auth/failure' => 'sessions#failure'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  post '/users/confirm' => 'users#confirm_users', as: 'confirm_users'
  post '/users/upload' => 'users#upload', as: 'csv_upload'
  post '/users/add' => 'users#add_user', as: 'add_user'


  get '/index' => 'workshft#index'
  
  
#     resources :policies
#       policies GET    /policies(.:format)          policies#index
# ?              POST   /policies(.:format)          policies#create
# *   new_policy GET    /policies/new(.:format)      policies#new
# *  edit_policy GET    /policies/:id/edit(.:format) policies#edit
# *       policy GET    /policies/:id(.:format)      policies#show
# ?              PATCH  /policies/:id(.:format)      policies#update
# ?              PUT    /policies/:id(.:format)      policies#update
# *              DELETE /policies/:id(.:format)      policies#destroy
  
  get '/policies/new' => 'policies#new', as: 'new_policy'
  get '/policies/edit' => 'policies#edit', as: 'edit_policy'
  get '/policies/' => 'policies#show', as: 'policy'
  post 'policies/' => 'policies#create'
  put '/policies/' => 'policies#update'
  
  
end