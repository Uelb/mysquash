class Rubrique < ActiveRecord::Base
	scope :displayed, -> {where(displayed: true)}
	
end
