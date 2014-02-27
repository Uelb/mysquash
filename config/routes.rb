Mysquash::Application.routes.draw do
	match 'inscriptions/check_user', to: 'inscriptions#check_user', via: [:get, :post]
	match 'no_tournament', to: 'pages#no_tournament', via: :get
	match 'inscriptions/upload', to: 'inscriptions#upload', via: [:get, :post]
	match 'popin_index', to: 'inscriptions#popin_index', via: [:get, :post]
	match 'lecons', to: 'pages#lecons', via: :get
	match 'preinscription', to: 'inscriptions#preinscription', via: :post
	get 'super_create', to: 'inscriptions#super_create'

	devise_for :users, :controllers => {:registrations => "registrations", :confirmations => "confirmations"}
	devise_for :admin_users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)
	resources :inscriptions
	resources :lecons_pictures
	root "tournaments#show", subdomain: "info"

end
