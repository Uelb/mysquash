class AddDisplayedToLeconsPictures < ActiveRecord::Migration
  def change
    add_column :lecons_pictures, :displayed, :boolean, default: true
  end
end
