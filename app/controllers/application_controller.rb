class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    edit_pulse_path(user.pulse)
  end
end
