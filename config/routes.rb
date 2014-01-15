Mysquash::Application.routes.draw do
	match 'inscriptions/check_user', to: 'inscriptions#check_user', via: [:get, :post]
	match 'no_tournament', to: 'pages#no_tournament', via: :get
	match 'inscriptions/upload', to: 'inscriptions#upload', via: [:get, :post]
	match 'popin_index', to: 'inscriptions#popin_index', via: [:get, :post]

	devise_for :users
	devise_for :admin_users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)
	resources :inscriptions
	root "tournaments#show"

end
