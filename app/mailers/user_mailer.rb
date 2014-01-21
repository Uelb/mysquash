#coding: UTF-8
class UserMailer < ActionMailer::Base
  default from: "admin@my-squash.com"

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

  def send_preinscription inscription
    @inscription = inscription
    @user = inscription.user
    mail(to: @user.email, subject: "Préinscription au prochain tournoi MySquash")
  end

  def send_tournament_opening tournament
    @emails = PreinscriptionEmail.pluck :email
    mail(to: "no-reply@my-squash.com", subject: "Les inscriptions au nouveau tournoi sont ouvertes", bcc: @emails)
  end
end
