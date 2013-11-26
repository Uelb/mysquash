class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :inscriptions
  has_many :tournaments, through: :inscriptions
  scope :male, where(male: true)
  scope :female, where(male: false)
  after_create :send_registration_mail

  def name
  	first_name + " " + last_name
  end

  def send_registration_mail
    UserMailer.registration_email(self).deliver
  end

end
