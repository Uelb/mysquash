# encoding: utf-8
ActiveAdmin.register User do
  filter :male, :as => :check_boxes, collection: [["Oui", true], ["Non", false]]
  filter :tournaments
  filter :email
  filter :first_name
  filter :last_name
  filter :licence
  filter :association
  filter :telephone_number

  
  index do
    column :email
    column :created_at
    column :first_name
    column :last_name
    column :licence
    column :association_name
    bool_column :male
    column :telephone_number
    column :confirmed_at
    default_actions
  end


end
