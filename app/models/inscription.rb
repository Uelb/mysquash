# encoding: utf-8
class Inscription < ActiveRecord::Base
	belongs_to :user
	belongs_to :tournament
	validates_presence_of :user_id, :tournament_id
	validates_uniqueness_of :user_id, scope: :tournament_id
	scope :validated_by_admin, -> {where(validated_by_admin: true)}
	scope :male, -> {joins(:user).merge(User.where(male: true))}
	scope :female, -> {joins(:user).merge(User.where(male: false))}

	before_create :check_tournament_limits
	after_create :send_preinscription_mail
	before_destroy :check_waiting_list


	def self.send_first_match_hour
		Tournament.opened.first.inscriptions.validated_by_admin
	end

	def admin_validate!
		if self.validated_by_admin
			return
		end
		self.validated_by_admin = true
		self.validation_date = DateTime.now
		self.save!
		send_inscription_validated_or_waiting_list_email
	end

	def user_validate!
		self.validated_by_user = true
		self.save!
	end

	def send_inscription_validated_or_waiting_list_email
		if self.waiting_list
			UserMailer.waiting_list_email(self).deliver
		else
			UserMailer.inscription_validated(self).deliver
		end
	end

	def resend_inscription_mail
		self.generate_token
		self.created_at = Time.now
		self.save!
		UserMailer.inscription_email(self).deliver
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

  	def check_tournament_limits
  		if self.user.male && self.tournament.male_full?
  			male = true
  		elsif !self.user.male && self.tournament.female_full?
  			male = false
  		end
  		if !male.nil?
  			self.waiting_list = (self.tournament.inscriptions.joins(:user).merge(User.where(male: male)).where.not(waiting_list: nil).count + 1)
		end
  	end

  	def check_waiting_list
      return true unless self.user
  		if self.user.male && self.tournament.male_full?
  			male = true
  			promoted_inscription = self.tournament.inscriptions.male	
  			
  		elsif !self.user.male && self.tournament.female_full?
  			male = false
  			promoted_inscription = self.tournament.inscriptions.female
  		end
  		if !male.nil?
  			promoted_inscription = promoted_inscription.where(waiting_list: 1).readonly(false).first
 	  		promoted_inscription.update_attribute(:waiting_list, nil)
			UserMailer.waiting_list_validated(promoted_inscription).deliver
			self.tournament.inscriptions.joins(:user).merge(User.where(male: male)).where("waiting_list > (?)", 1).each do |inscription|
				inscription.update_attribute(:waiting_list, inscription.waiting_list-1 )
			end
  		end
  	end

  	def send_preinscription_mail
  		if self.preinscription
  			UserMailer.send_preinscription(self).deliver
  		end
  	end
end
