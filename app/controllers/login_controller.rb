class LoginController < ApplicationController
  def index
    if request.post?
			logger.debug("parameters: #{params.inspect}")
			logged_in_account = login_account_by_params(params[:account][:email], params[:account][:password])
			if logged_in_account
        session[:account_id] = logged_in_account.id
        session[:email] = logged_in_account.email
        session[:name] = logged_in_account.name
        redirect_to session[:return_path] and return if session[:return_path]
        redirect_to root_path
			else
				flash.now[:error] = "Invalid email/password combination"
			end
    end
  end

  def logout
    session[:account_id] = nil
    session[:email] = nil
    session[:profile_pic] = nil
    session[:name] = nil
    redirect_to main_app.root_path
  end

  private
	def login_account_by_params(email, password)
		return nil if email.blank? || password.blank?
    account = Account.new
    account.email = email
    account.password = password
    logged_in_account = account.validate_login
		return logged_in_account
	end
end
