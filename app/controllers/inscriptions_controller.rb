# encoding: utf-8

class InscriptionsController < ApplicationController

	layout 'inscriptions'

	def create
		@inscription = Inscription.new
		@inscription.user = User.where(email: params[:email_confirmation]).first
		@inscription.preinscription = (params[:preinscription] == "1")
		if !@inscription.preinscription && (!@inscription.user || !@inscription.user.validate_user_information(params[:email_confirmation], params[:phone_number_confirmation]))
			redirect_to(root_path, notice: "Les informations que vous avez entrées sont incorrects.") and return
		end
		@inscription.tournament = Tournament.where(id: params[:tournament_id]).first
		if @inscription.valid?
			@inscription.save
			if @inscription.preinscription
				text = "Votre demande d'information a bien été enregistrée, vous recevrez un mail d'information à l'occasion du prochain tournoi organisé par My Squash. Bonne journée."
			else
				text = "Votre inscription est en attente de validation par un administrateur. Vous recevrez un email aussitôt que possible."
			end
		else
			old_inscription = @inscription.user.inscriptions.where(tournament_id: params[:tournament_id]).first
			if old_inscription && old_inscription.validated_by_admin
				text = "Vous êtes déjà inscrit à ce tournoi et votre inscription a été validé. Vous recevrez un email lorsque les horaires des premiers matches seront disponibles."
			elsif old_inscription.preinscription
				text = "Nous avions déjà enregistré votre demande. Vous recevrez un mail d'information à l'occasion du prochain tournoi organisé par My Squash. Bonne journée."
			else
				text = "Nous avons déjà pris en compte votre inscription. Elle est en attente de validation par un administrateur. Vous recevrez un email aussitôt que possible."
			end
		end
		sign_in @inscription.user if @inscription.user.confirmed?
		if $website_special_mode
			session[:popin_closed] = true
		end
		redirect_to root_path, notice: text
	end

	def new
		@user = User.where(email: params[:email]).first
		@tournament = Tournament.where(id: params[:tournament_id]).first
		render layout: false
	end

	def check_user
		user = User.where(email: params[:email]).first
		if user.confirmed?
			render :nothing => true, :status => 200, :content_type => 'text/html'
		elsif user
			user.resend_confirmation_instructions
			render :partial => "inscriptions/not_confirmed_user", :status => 201, :content_type => 'text/html'
		else
			render :nothing => true, :status => 412, :content_type => 'text/html'
		end
	end

	def index
		@tournament = Tournament.includes(:users, :inscriptions => :user).where(id: params[:tournament_id]).first
		@inscriptions = @tournament.inscriptions
		@males = @tournament.users.where(male: true)
		@females = @tournament.users.where(male: false)
		if current_user
          @current_user_inscription = @inscriptions.where(user_id: current_user.id).first
		end
		render layout: false
	end

	def edit 
		inscription = Inscription.where(id: params[:id]).first
		if inscription.user_id == current_user.id
			inscription.user_validate!
		end
		redirect_to root_path
	end


	def update
		@inscription||= Inscription.where(id: params[:id]).first
		@user = @inscription.user
		notice = "Une erreur s'est produite, veuillez réessayer."
		if @user.validate_user_information params[:email_confirmation], params[:phone_number_confirmation]
			@inscription.send_inscription_or_waiting_list_email
			notice = "Vous venez de recevoir un email, veuillez cliquer sur le lien présent dans l'email"
		end

		redirect_to root_path, notice: notice
	end

	def upload
		uploaded_io = params[:excel]
		filename = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
  		file = File.open(filename, 'wb') do |file|
    		file.write(uploaded_io.read)
  		end
  		@imported_matches, @not_imported_indexes = Inscription.import_last_excel(filename)
  		notice = "#{@imported_matches} matchs ont correctement été importés. Les lignes #{@not_imported_indexes.join(" ,")} n'ont pas été traitées"
  		redirect_to admin_dashboard_path, notice: notice
	end

	def validate 
		Inscription.where(id: params[:id]).user_validate!
	end

	def popin_index
		p session[:popin_closed]
		if !$website_special_mode || session[:popin_closed]
			redirect_to root_path and return 
		end
		if current_user
			user = current_user
		else
			user = User.where(email: params[:popin_email], telephone_number: params[:popin_phone_number]).first
		end
		@next_tournament = Tournament.where(published_in_next_tournament: true).first
		if user
			sign_in user
			@tournament = Tournament.includes(:users, :inscriptions => :user).opened.first
			@inscriptions = @tournament.inscriptions
			@males = @tournament.users.where(male: true)
			@females = @tournament.users.where(male: false)
			if current_user
		      @current_user_inscription = @inscriptions.where(user_id: current_user.id).first
			end
			render layout: "popin"
		else
			redirect_to root_path, alert: "Nous n'avons pas réussi à vous identifier... Veuillez réessayer."
		end
	end

end
