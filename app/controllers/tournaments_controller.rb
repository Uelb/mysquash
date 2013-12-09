class TournamentsController < ApplicationController

	layout 'inscriptions'

	def show
		@tournament = Tournament.opened.first
		@males = @tournament.users.males
		@females = @tournament.users.females
		@inscriptions = @tournament.inscriptions
		@next_tournament = Tournament.where(published_in_next_tournament: true).first
		redirect_to no_tournament_path if @tournament.nil?
	end

end
