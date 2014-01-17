class CreateRubriques < ActiveRecord::Migration
  def change
    create_table :rubriques do |t|
      t.string :title
      t.text :description
      t.string :button_text
      t.string :button_link
      t.boolean :displayed, default: true

      t.timestamps
    end
  end
end
