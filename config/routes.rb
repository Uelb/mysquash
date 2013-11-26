Mysquash::Application.routes.draw do
	match 'inscriptions/check_user', to: 'inscriptions#check_user', via: [:get, :post]

	devise_for :users
	devise_for :admin_users, ActiveAdmin::Devise.config
	ActiveAdmin.routes(self)
	resources :inscriptions
	root "tournaments#show"

end
