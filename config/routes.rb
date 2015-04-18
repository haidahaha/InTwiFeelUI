Rails.application.routes.draw do

  post 'create' => 'products#create'
  delete 'delete' => 'products#destroy'

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
