class Intern::ConfirmationsController < ::Devise::ConfirmationsController
  def show
    flash[:error] = 'Dein Anmeldelink ist nicht valide' if params[:confirmation_token].blank?
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])

    redirect_to intern_root_path if resource.nil? && intern_user_signed_in?
    super if resource.nil? && !intern_user_signed_in?
  end

  def confirm
    flash[:error] = 'Dein Anmeldelink ist nicht valide' if params[resource_name][:confirmation_token].blank?

    self.resource = resource_class.find_by_confirmation_token(params[resource_name][:confirmation_token])

    if resource && resource.update_attributes(params[resource_name].except(:confirmation_token)) && resource.passwords_match?
      self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])

      set_flash_message :notice, :confirmed

      sign_in_and_redirect(resource_name, resource)
    else
      render :action => :show
    end
  end
end
