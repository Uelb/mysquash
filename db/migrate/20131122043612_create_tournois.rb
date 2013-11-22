class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.datetime :date
      t.string :title
      t.text :description
      t.boolean :open
      t.integer :mens_limit
      t.integer :womens_limit
      t.boolean :published_in_next_tournament

      t.timestamps
    end
  end
end
