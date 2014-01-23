# encoding: utf-8
ActiveAdmin.register Rubrique do

  permit_params :title, :description, :button_text, :button_link, :displayed
  

  index do 
		column :title
		column :description
		column :button_text
		column :button_link
		bool_column :displayed
		default_actions
	end
  
end
