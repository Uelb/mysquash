class InscriptionsController < ApplicationController

	def create
		@inscription = Inscription.new
		@inscription.user = User.where(email: params[:email]).first
		@inscription.tournament = Tournament.where(params[:tournament_id]).first
		@inscription.preinscription = (params[:preinscription] == "1")
		@inscription.save
		redirect_to 
	end

	def check_user
		if User.where(email: params[:email]).first
			render :nothing => true, :status => 200, :content_type => 'text/html'
		else
			render :nothing => true, :status => 412, :content_type => 'text/html'
		end
	end

	def index
		@tournament = Tournament.includes(:users, :inscriptions => :user).where(id: params[:tournament_id]).first
		@inscriptions = @tournament.inscriptions
		@males = @tournament.users.males
		@females = @tournament.users.females
		render layout: false
	end

end
