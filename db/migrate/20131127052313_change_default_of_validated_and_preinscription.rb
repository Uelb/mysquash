class ChangeDefaultOfValidatedAndPreinscription < ActiveRecord::Migration
  def change
  	change_column :inscriptions, :validated_by_admin,:boolean, default: false
  	change_column :inscriptions, :preinscription,:boolean, default: false
  end
end
