class NameErrorForTournaments < ActiveRecord::Migration
  def change
  	rename_column :tournaments, :mens_limit, :men_limit
  	rename_column :tournaments, :womens_limit, :women_limit
  end
end
