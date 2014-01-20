class CreateLeconsPictures < ActiveRecord::Migration
  def change
    create_table :lecons_pictures do |t|
	  t.attachment :picture

      t.timestamps
    end
  end
end
