class  ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    super
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ redirect_to root_path, notice: "Une erreur s'est produite, peut-être que votre compte est déja confirmé. Veuillez remplir le formulaire d'inscription à nouveau, et si le problème persite, n'hésitez pas à nous écrire." }
    end
  end
end