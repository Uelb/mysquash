# encoding: utf-8
# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    redirect_to root_path and return
  end

  def create
    resource = User.where(email: sign_up_params[:email]).first

    if resource.update_attributes sign_up_params.slice!(:email)
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        redirect_to controller: :inscriptions, action: :super_create, email: resource.email, email_confirmation: resource.email, phone_number_confirmation: resource.telephone_number, tournament_id: Tournament.opened.first.id
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        redirect_to controller: :inscriptions, action: :super_create, email: resource.email, email_confirmation: resource.email, phone_number_confirmation: resource.telephone_number, tournament_id: Tournament.opened.first.id
      end
    else
      clean_up_passwords resource
      redirect_to root_path, alert: "Une erreur s'est produite. Vous devez entrer au moins les informations suivantes : Nom, prénom, numéro de téléphone, Homme ou femme."
    end
  end

  def update
    super
  end

  protected

  def after_sign_up_fail_path_for(resource)
    respond_to?(:root_path) ? root_path : "/"
  end
end 