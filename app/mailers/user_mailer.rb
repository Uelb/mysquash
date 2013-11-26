class UserMailer < ActionMailer::Base
  default from: "admin@mysquash.fr"

  def inscription_email inscription, user
  	@user = user
  	@inscription = inscription
  	@tournament = inscription.tournament
  	mail(to: user.email, subject: "Votre inscription au prochain tournoi : #{tournament.title}")
  end

  def mail_to_users(body, subject="Mail from the mysquash admin", users=[])
  	@body = body
  	users= User.where(id: users).map(&:email)
  	mail(:to => users, :subject => subject)
  	#mail(:to => User.pluck(:email), :subject => subject)
  end

  def registration_email user

  end
end
