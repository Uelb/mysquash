class AddFirstMatchDateToInscriptions < ActiveRecord::Migration
  def change
    add_column :inscriptions, :first_match_date, :datetime
  end
end
