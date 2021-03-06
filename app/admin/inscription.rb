# encoding: utf-8

ActiveAdmin.register Inscription do

  config.sort_order = "created_at desc"
  filter :tournament
  filter :validated_by_admin
  filter :validated_by_user
  filter :first_match_date

  permit_params :user_id, :tournament_id, :first_match_date, :comment

  batch_action :valider do |selection|
    Inscription.find(selection).each do |inscription|
      inscription.validate!
    end

    redirect_to collection_path, :notice => "Inscriptions validées!"

  end

  member_action :validate, method: :put do 
  	inscription = Inscription.find params[:id]
  	inscription.admin_validate!
  	redirect_to collection_path, notice: "Inscription validées"
  end

  collection_action :fill_first_match_dates, method: :put do
    
    redirect_to collection_path notice: "Les dates des premiers matches ont été mises à jour."
  end

  action_item only: :show do 
  	link_to "Valider", validate_admin_inscription_path(inscription), method: :put
  end

  form do |f|
  	f.inputs "Details" do 
      f.input :tournament
      f.input :user
  		f.input :comment
  		f.input :first_match_date
  	end	
  	f.actions
  end

  index do 
    selectable_column  
    column :user
    column :tournament
    column :validated_by_admin
    column :preinscription
    column :validated_by_user
    column :waiting_list
    column :first_match_date
    actions defaults: true do |inscription|
      link_to "Valider", validate_admin_inscription_path(inscription), method: :put
    end
  end
  
end
