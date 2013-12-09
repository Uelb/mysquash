class DeleteCurrentFromTournaments < ActiveRecord::Migration
  def change

  	remove_column :tournaments, :current, :boolean
  end
end
