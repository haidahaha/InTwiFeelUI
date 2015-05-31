Rails.application.routes.draw do

  post 'create' => 'products#create'
  delete 'delete' => 'products#destroy'
  get 'products/:name/live' => 'products#live', as: 'live'
  get 'products/:name/history' => 'products#history', as: 'history'
  # post 'products/:name/history/:from/:to' => 'products#history', as: 'history'
  post 'add_data_point' => 'products#add_data_point'

  get 'show' => 'users#show'
  post 'show' => 'users#show'
  get 'login' => 'sessions#new'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  root 'sessions#new'
  get 'about' => 'static_pages#about'


  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end
