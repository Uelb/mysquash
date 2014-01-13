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
		if self.men_limit.nil? then return false end
		self.users.males.count >= self.men_limit
	end

	def female_full?
		if self.women_limit.nil? then return false end
		self.users.females.count >= self.women_limit
	end
end
