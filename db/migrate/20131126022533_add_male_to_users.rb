class AddMaleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :male, :boolean, default: true
  end
end
