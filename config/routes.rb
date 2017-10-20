Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  #users controller
  get 'signup' => 'users#new'
  get 'users' => 'users#new'

  #roleplays controller
  delete '/roleplays/:roleplay_id' => 'roleplays#destroy'
  post '/roleplays/start/:id' => 'roleplays#start'
  post '/roleplays/stop/:id' => 'roleplays#stop'
  post '/roleplays/add_dummy/:id' => 'roleplays#add_dummy'
  get '/roleplay/new' => 'roleplays#new'
  get '/roleplays/message_to_append/:character_id', to: 'roleplays#message_to_append', as: 'message_to_append'
  resources :roleplays
 
  #messages controller
  post 'messages/save_message', to: 'messages#save_message', as: 'save_message'
 

  post '/' => 'sessions#create'
  delete '/' => 'sessions#destroy'
  get '/dashboard' => 'dashboard#index'
  root 'dashboard#index'
  
  
  post  '/characters/claim' => 'characters#claim'
  delete '/characters/:character' => 'characters#destroy'
  post  '/characters/unbind' => 'characters#unbind'
  post '/characters/assign' => 'characters#assign'
 
  resources :users
  
  resources :characters
  mount ActionCable.server => '/cable'
end

