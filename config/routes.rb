Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'signup' => 'users#new'
  get 'users' => 'users#new'
  post '/' => 'sessions#create'
  delete '/' => 'sessions#destroy'
  get '/dashboard' => 'dashboard#index'
  root 'dashboard#index'
  get '/roleplay/new' => 'roleplays#new'
  delete '/roleplays/:roleplay_id' => 'roleplays#destroy'
  post  '/characters/claim' => 'characters#claim'
  delete '/characters/:character' => 'characters#destroy'
  post  '/characters/unbind' => 'characters#unbind'
  post '/characters/assign' => 'characters#assign'
  post '/roleplays/start/:id' => 'roleplays#start'
  post '/roleplays/stop/:id' => 'roleplays#stop'
  resources :users
  resources :roleplays
  resources :characters
  mount ActionCable.server => '/cable'
end

