class InternController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_intern_user!
end
