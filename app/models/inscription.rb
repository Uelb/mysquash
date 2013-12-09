class Inscription < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament
	validates_presence_of :user_id, :tournament_id
	validates_uniqueness_of :user_id, scope: :tournament_id

	after_create :send_inscription_or_waiting_list_email
	before_create :generate_token
	before_create :check_tournament_limits

	def validate!
		self.validated_by_admin = true
		self.validation_date = DateTime.now
		self.save!
		if self.waiting_list
			UserMailer.waiting_list_validated(self).deliver
		else
			UserMailer.inscription_validated(self).deliver
		end
	end

	def send_inscription_or_waiting_list_email
		if self.waiting_list
			UserMailer.waiting_list_email(self).deliver
		else
			UserMailer.inscription_email(self).deliver
		end
	end

	def resend_inscription_mail
		generate_token
		created_at = Time.now
		save!
		send_inscription_email
	end

	protected

  	def generate_token
    	self.token = loop do
      		random_token = SecureRandom.urlsafe_base64(nil, false)
      		break random_token unless Inscription.exists?(token: random_token)
    	end
  	end

  	def check_tournament_limits
  		if self.user.male && self.tournament.male_full? || !self.user.male && self.tournament.female_full?
  			self.waiting_list = (self.tournament.inscriptions.pluck(:waiting_list).max||0 + 1)
  		end
  	end
end
