class InscriptionsController < ApplicationController

	def create
		@inscription = Inscription.new
		@inscription.user = User.where(email: params[:email]).first
		@inscription.tournament = Tournamenet.where(params[:tournament_id]).first
		@inscription.preinscription = (params[:preinscription] == "1")
		@inscription.save
	end

end
