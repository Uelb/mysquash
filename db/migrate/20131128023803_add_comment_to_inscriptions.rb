class AddCommentToInscriptions < ActiveRecord::Migration
  def change
    add_column :inscriptions, :comment, :text
  end
end
