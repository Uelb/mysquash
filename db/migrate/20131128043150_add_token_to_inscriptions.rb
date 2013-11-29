class AddTokenToInscriptions < ActiveRecord::Migration
  def change
    add_column :inscriptions, :token, :string
  end
end
