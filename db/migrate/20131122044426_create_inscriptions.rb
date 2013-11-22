class CreateInscriptions < ActiveRecord::Migration
  def change
    create_table :inscriptions do |t|
      t.datetime :validation_date
      t.boolean :validated_by_admin
      t.boolean :preinscription
      t.references :user
      t.references :tournament

      t.timestamps
    end
  end
end
