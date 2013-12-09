class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :inscriptions
  has_many :tournaments, through: :inscriptions
  scope :males, where(male: true)
  scope :females, where(male: false)
  validates_presence_of :first_name, :last_name

  def name
  	first_name + " " + last_name
  end

  def validate_user_information email, phone_number
    return self.email == email && self.phone_number == phone_number
  end 
end
