# encoding: utf-8
class PagesController < ApplicationController

	def no_tournament
		
		
	end

	def lecons
		@rubriques = Rubrique.all
		@pictures = LeconsPicture.displayed.map(&:picture)
		@comments = LeconsComment.displayed
		render layout: "lecons"
	end
end
