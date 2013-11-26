class ChangeNameOfAssociationColumnForUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :association, :association_name
  end
end
