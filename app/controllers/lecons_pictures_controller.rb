class LeconsPicturesController < ApplicationController

	permit_params :picture, :utf8, :authenticity_token, :commit

	def create
		@picture = LeconsPicture.create(params)
	end
end
