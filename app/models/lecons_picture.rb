class LeconsPicture < ActiveRecord::Base
	has_attached_file :picture, :styles => { :large => "500x500>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment :picture, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png", "image/jpeg"] }
	validates :picture, :attachment_presence => true
	scope :displayed, -> {where(displayed: true)}

end