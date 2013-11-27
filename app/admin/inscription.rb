ActiveAdmin.register Inscription do

  batch_action :validate do |selection|
    Inscription.find(selection).each do |inscription|
      inscription.validate!
    end

    redirect_to collection_path, :notice => "Inscriptions validated!"

  end
  
end
