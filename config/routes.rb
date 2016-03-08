Rails.application.routes.draw do

  root to: 'workshift#index'

  resources :users do
    collection { post :import }
  end
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  
  get '/api/users' => 'users#get_all', as: 'get_all_users'
  
  post '/users/upload' => 'users#upload', as: 'csv_upload'

  get '/index' => 'workshft#index'

end