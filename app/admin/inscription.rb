# encoding: utf-8

ActiveAdmin.register Inscription do

  permit_params :first_match_date, :comment

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
    column :created_at
    column :comment
    column :waiting_list
    column :first_match_date
    actions defaults: true do |inscription|
      link_to "Valider", validate_admin_inscription_path(inscription), method: :put
    end
  end
  
end
