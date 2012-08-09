class InternController < ActionController::Base
  include CancanOverride

  protect_from_forgery

  before_filter :authenticate_intern_user!
end
