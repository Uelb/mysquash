class AddWaitingListToInscriptions < ActiveRecord::Migration
  def change
    add_column :inscriptions, :waiting_list, :integer
  end
end
