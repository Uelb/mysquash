# encoding: utf-8
ActiveAdmin.register User do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
  index do
    column :email
    column :created_at
    column :first_name
    column :last_name
    column :licence
    column :association_name
    column :male
    column :telephone_number
    column :confirmed_at
    default_actions
  end


end
