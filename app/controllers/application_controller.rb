class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :fix_cas_session

  helper_method :current_user
  helper_method :current_admin

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def fix_cas_session
    if session[:cas].respond_to?(:with_indifferent_access)
      session[:cas] = session[:cas].with_indifferent_access
    end
  end

  def require_user
    unless current_user
      render status: 401, text: "Redirecting to SSO..."
    end
  end

  def current_user
    return @current_user if defined?(@user)

    @current_user = if session[:cas].nil? || session[:cas][:user].nil?
                      nil
                    else
                      User.where(netid: session[:cas][:user]).first_or_create!(session: session[:cas].to_json)
                    end
  end

  def current_admin
    current_user.try(:admin?) && current_user
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
