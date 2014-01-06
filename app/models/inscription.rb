class Inscription < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament
	validates_presence_of :user_id, :tournament_id
	validates_uniqueness_of :user_id, scope: :tournament_id

	after_create :send_inscription_or_waiting_list_email
	before_create :generate_token
	before_create :check_tournament_limits
	before_destroy :check_waiting_list

	def user_validate!
		if self.validated_by_user
			return
		end
		self.validated_by_user = true
		self.save!
		send_inscription_or_waiting_list_email
	end

	def send_inscription_or_waiting_list_email
		if self.waiting_list
			UserMailer.waiting_list_email(self).deliver
		else
			UserMailer.inscription_email(self).deliver
		end
	end

	def resend_inscription_mail
		self.generate_token
		self.created_at = Time.now
		self.save!
		self.send_inscription_or_waiting_list_email
	end

	def self.import_last_excel io_or_path
		@imported_matches = 0
		@not_imported_indexes = []
		@workbook = Spreadsheet.open io_or_path
		@worksheet = @workbook.worksheet(0)
		inscriptions  = Tournament.opened.first.inscriptions
		users = Tournament.opened.first.users
		0.upto @worksheet.last_row_index do |index|
			# .row(index) will return the row which is a subclass of Array
			row = @worksheet.row(index)
			licence = row[6] && row[6].downcase
			first_name = row[5] && row[5].downcase
			last_name = row[4] && row[4].downcase
			first_match_date = row[14]
			p licence
			p users.map(&:licence)
			user = users.select do |user|
				(user.licence.downcase && user.licence.downcase == licence) || (user.first_name.downcase == first_name && user.last_name.downcase == last_name)
			end
			user = user.first
			if user && users.include?(user)
				inscription = inscriptions.where(user_id: user.id).first
				inscription.first_match_date = Time.zone.parse first_match_date
				inscription.save!
				@imported_matches+=1
			else
				@not_imported_indexes << index
			end
		end
		return @imported_matches, @not_imported_indexes
	end

	protected

  	def generate_token
    	self.token = loop do
      		random_token = SecureRandom.urlsafe_base64(nil, false)
      		break random_token unless Inscription.exists?(token: random_token)
    	end
  	end

  	def check_tournament_limits
  		if self.user.male && self.tournament.male_full?
  			self.waiting_list = (self.tournament.inscriptions.pluck(:waiting_list).max||0 + 1)
  		elsif !self.user.male && self.tournament.female_full?
  		end
  	end

  	def check_waiting_list
  		if self.user.male && self.tournament.male_full?
  			male = true
  			promoted_inscription = self.tournament.inscriptions.where("user.male = (?)", true).where(waiting_list: 1)	
  			
  		elsif !self.user.male && self.tournament.female_full?
  			male = false
  			promoted_inscription = self.tournament.inscriptions.where("user.male = (?)", false).where(waiting_list: 1)
  		end
  		if !male.nil?
  			promoted_inscription = self.tournament.inscriptions.where("user.male = (?)", male).where(waiting_list: 1)
	  		promoted_inscription.waiting_list = nil
			promoted_inscription.save!
			UserMailer.waiting_list_validated(promoted_inscription).deliver
			self.tournament.inscriptions.where("user.male = (?)", male).where.not(waiting_list: nil).each do |inscription|
				inscription.waiting_list-=1
				inscription.save!
			end
  		end
  	end
end
