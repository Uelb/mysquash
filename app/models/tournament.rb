class Tournament < ActiveRecord::Base
	has_many :inscriptions
	has_many :users, through: :inscriptions
	before_save :check_that_there_is_only_one_current

	def check_that_there_is_only_one_current
		if self.current
			Tournament.update_all current: false
		end
	end

end
