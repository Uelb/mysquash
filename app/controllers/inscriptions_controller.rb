# encoding: utf-8

class InscriptionsController < ApplicationController

	def create
		@inscription = Inscription.new
		@inscription.user = User.where(email: params[:email]).first
		@inscription.tournament = Tournament.where(id: params[:tournament_id]).first
		@inscription.preinscription = (params[:preinscription] == "1")
		if @inscription.valid?
			@inscription.save
			redirect_to action: :index, tournament_id: params[:tournament_id]
		else
			text = "Une erreur s'est produite lors de votre inscription. Veuillez réessayer et si le problème persiste, contacter l'administrateur de My Squash. The error is #{@inscription.errors}"
			render text: text
		end
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
		@males = @tournament.users.where(male: true)
		@females = @tournament.users.where(male: false)
		render layout: false
	end

end
