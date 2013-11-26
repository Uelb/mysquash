class AddCurrentToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :current, :boolean, default: false, null: false
  end
end
