# encoding: utf-8
class Rubrique < ActiveRecord::Base
	scope :displayed, -> {where(displayed: true)}
	
end
