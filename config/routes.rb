Rails.application.routes.draw do

  root 'pages#index'
  get 'pages/index'

  devise_for :users, 
  	path: '', 
  	path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile'},
  	controllers: {:omniauth_callbacks => 'omniauth_callbacks', :registrations => 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :users, only: [:show]

  resources :rooms do
    resources :reservations, only: [:create]
  end
  
	resources :photos
  resources :contacts, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  get '/preload' => 'reservations#preload'
  get '/preview' => 'reservations#preview'
  get '/trips' => 'reservations#trips'
  get '/my_reservations' => 'reservations#my_reservations'
	  
end
