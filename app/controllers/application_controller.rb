class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  protected
  def layout_by_resource
    if devise_controller?
      'intern'
    else
      'application'
    end
  end

  private
  def after_sign_out_path_for(resource_or_scope)
    intern_root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    intern_root_path
  end
end
