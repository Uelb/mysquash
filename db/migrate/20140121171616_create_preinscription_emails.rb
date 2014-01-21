class CreatePreinscriptionEmails < ActiveRecord::Migration
  def change
    create_table :preinscription_emails do |t|
      t.string :email, null: false

      t.timestamps
    end
  end
end
