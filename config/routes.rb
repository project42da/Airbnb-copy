Rails.application.routes.draw do
	root 'pages#index'
  get 'pages/index'

  devise_for :users, 
  	path: '', 
  	path_name: {sign_in: 'login', sign_out: 'logout', edit: 'profile'},
  	controllers: {:omniauth_callbacks => 'omniauth_callbacks'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
