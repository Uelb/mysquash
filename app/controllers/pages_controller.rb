class PagesController < ApplicationController

	def no_tournament
		
		
	end

	def lecons
		@rubriques = Rubrique.all
		@pictures = LeconsPicture.displayed.map(&:picture)
		render layout: "lecons"
	end
end
