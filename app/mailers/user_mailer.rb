class UserMailer < ActionMailer::Base
  default from: "admin@mysquash.fr"

  def inscription_email inscription
  	@user = inscription.user
  	@inscription = inscription
  	@tournament = inscription.tournament
  	mail(to: @user.email, subject: "Confirmation de la boite mail #{@user.email}")
  end

  def inscription_validated inscription
    @user = inscription.user
    mail(to: @user.email, subject: "Confirmation de l'inscription au tournoi")
  end

  def waiting_list_email inscription
    @inscription = inscription
    @user = inscription.user
    mail(to: @user.email, subject: "Inscription sur liste d'attente")
  end

  def waiting_list_validated inscription
    @inscription = inscription
    @user = inscription.user
    mail(to: @user.email, subject: "Inscription sur liste d'attente (Suite)")
  end

  def mail_to_users(body, subject="Mail from the mysquash admin", users=[])
  	@body = body
  	users= User.where(id: users).map(&:email)
  	mail(:to => users, :subject => subject)
  end
end
