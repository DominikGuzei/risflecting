class InternController < ActionController::Base
  include CancanOverride

  protect_from_forgery

  before_filter :authenticate_intern_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to intern_root_url, :flash => { :error => exception.message }
  end
end
