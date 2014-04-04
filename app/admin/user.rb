# encoding: utf-8
ActiveAdmin.register User do

  permit_params :email, :first_name, :last_name, :licence, :association, :telephone_number

  filter :male, :as => :check_boxes, collection: [["Oui", true], ["Non", false]]
  filter :tournaments
  filter :email
  filter :first_name
  filter :last_name
  filter :licence
  filter :association_name
  filter :telephone_number


  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :licence
      f.input :association_name
      f.input :telephone_number
    end 
    f.actions
  end
  
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
