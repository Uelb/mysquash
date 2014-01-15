class PagesController < ApplicationController

	def no_tournament
		
		
	end

	def lecons
		@rubriques = Rubrique.all
		render layout: "lecons"
	end
end
