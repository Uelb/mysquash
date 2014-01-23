class LeconsComment < ActiveRecord::Base
	scope :displayed, -> {where(displayed: true)}


end
