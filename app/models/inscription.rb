class Inscription < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament
	validates_presence_of :user_id, :tournament_id
	validates_uniqueness_of :user_id, scope: :tournament_id

	def validate!
		self.validated_by_admin = true
		self.validation_date = DateTime.now
		self.save!
	end
end
