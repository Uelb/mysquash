class Inscription < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament
	validates_presence_of :user_id, :tournament_id
	validates_uniqueness_of :user_id, scope: :tournament_id

	after_create :send_inscription_email
	before_create :generate_token

	def validate!
		self.validated_by_admin = true
		self.validation_date = DateTime.now
		self.save!
	end

	def send_inscription_email
		UserMailer.inscription_email(self).deliver!
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
end
