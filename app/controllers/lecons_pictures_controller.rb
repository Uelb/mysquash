# encoding: utf-8
class LeconsPicturesController < ApplicationController

	def create
		@picture = LeconsPicture.create(params)
	end
end
