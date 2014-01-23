class CreateLeconsComments < ActiveRecord::Migration
  def change
    create_table :lecons_comments do |t|
      t.text :comment
      t.string :author
      t.boolean :displayed, default: true, null: false

      t.timestamps
    end
  end
end
