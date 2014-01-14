class DeleteTokenAndValidatedByUserFromInscriptions < ActiveRecord::Migration
  def change
  	remove_column :inscriptions, :token
  	remove_column :inscriptions, :validated_by_user
  end
end
