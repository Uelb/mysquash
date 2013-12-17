# encoding: utf-8

ActiveAdmin.register Inscription do

  batch_action :validate do |selection|
    Inscription.find(selection).each do |inscription|
      inscription.validate!
    end

    redirect_to collection_path, :notice => "Inscriptions validated!"

  end

  member_action :validate, method: :put do 
  	inscription = Inscription.find params[:id]
  	inscription.validate!
  	redirect_to collection_path, notice: "Inscription Validated"
  end

  collection_action :fill_first_match_dates, method: :put do
    
    redirect_to collection_path notice: "Les dates des premiers matches ont été mises à jour."
  end

  action_item only: :show do 
  	link_to "Validate", validate_admin_inscription_path(inscription), method: :put
  end

  form do |f|
  	f.inputs "Details" do 
  		f.input :comment
  		f.input :first_match_date
  	end	
  	f.actions
  end
  
end
