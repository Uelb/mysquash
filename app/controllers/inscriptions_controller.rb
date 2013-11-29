# encoding: utf-8

class InscriptionsController < ApplicationController

	layout 'inscriptions'

	def create
		@inscription = Inscription.new
		@inscription.user = User.where(email: params[:email]).first
		@inscription.tournament = Tournament.where(id: params[:tournament_id]).first
		@inscription.preinscription = (params[:preinscription] == "1")
		if @inscription.valid?
			@inscription.save
			render partial: "inscriptions/inscription_success"
		else
			old_inscription = @inscription.user.inscriptions.where(tournament_id: params[:tournament_id]).first
			if old_inscription
				if old_inscription.validated_by_user
					text = "Vous êtes déjà inscrit à ce tournoi."
				else
					old_inscription.resend_inscription_mail
					text = "Vous êtes inscrit à ce tournoi mais vous n'avez pas confirmé votre inscription. Un nouveau mail vient de vous être envoyés."
				end
			else
				text = "Une erreur s'est produite lors de votre inscription. Veuillez réessayer et si le problème persiste, contacter l'administrateur de My Squash. The error is #{@inscription.errors}"
			end
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

	def edit
		@user = current_user
		@inscription = Inscription.where(id: params[:id]).first
		@tournament = @inscription.tournament
		if @inscription.token != params[:token] || @inscription.created_at < 1.day.ago
			redirect_to root_path, notice: "Vous n'êtes pas autorisé à accéder à cette page. Veuillez recommencer votre inscription"
		end
		if @inscription.validated_by_user
			redirect_to root_path, notice: "Vous avez déjà validé votre inscription."
		end
	end

end
