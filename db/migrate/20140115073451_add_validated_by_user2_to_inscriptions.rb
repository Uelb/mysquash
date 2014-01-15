class AddValidatedByUser2ToInscriptions < ActiveRecord::Migration
  def change
    add_column :inscriptions, :validated_by_user, :boolean, default: false
  end
end
