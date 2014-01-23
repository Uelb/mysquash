# encoding: utf-8
class PreinscriptionEmail < ActiveRecord::Base
	validates_presence_of :email
	validates_uniqueness_of :email

end
