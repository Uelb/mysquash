class TournamentsController < ApplicationController

	def show
		@tournament = Tournament.where(id: params[:id]).first
		@tournament||= Tournament.last
		@next_tournament = Tournament.where(published_in_next_tournament: true).first
	end

end
