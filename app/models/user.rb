# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :inscriptions
  has_many :tournaments, through: :inscriptions
  scope :males, -> {where(male: true)}
  scope :females, -> {where(male: false)}
  validates_presence_of :first_name, :last_name, on: :update

  def name
    first_name.to_s + " " + last_name.to_s
  end

  def validate_user_information email, telephone_number
    return self.email == email && self.telephone_number == telephone_number
  end 

  protected 
  def password_required? 
    false 
  end 
end
