class Tournament < ActiveRecord::Base
	has_many :inscriptions
	has_many :users, through: :inscriptions
	before_save :check_that_there_is_only_one_current
	scope :opened, -> {where(open: true)}

	def check_that_there_is_only_one_current
		if self.open
			Tournament.update_all open: false
			self.open = true
			self.published_in_next_tournament = false
		end
		true
	end

	def open!
		self.open = true
		self.published_in_next_tournament = false
		self.save
	end

	def male_full?
		self.users.males.count >= self.mens_limit
	end

	def female_full?
		self.users.females.count >= self.mens_limit
	end

end
