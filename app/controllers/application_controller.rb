class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize
    if !(session[:account_id] and session[:email])
      redirect_to login_path
    end
  end

  def current_user
    return nil if session[:email].blank?
    @current_user ||= Account.find_by_email(session[:email])
  end
end
