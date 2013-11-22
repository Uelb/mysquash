class Tournament < ActiveRecord::Base
	has_many :inscriptions
	has_many :users, through: :inscriptions
end
