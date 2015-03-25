class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :fix_cas_session
  before_action :require_user
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
    if session[:cas].nil? || session[:cas][:user].nil?
      render status: 401, text: "Redirecting to SSO..."
    else
      @current_user ||= User.where(netid: session[:cas][:user]).first_or_create!(session: session[:cas].to_json)
    end
  end

  def skip_login?
    false
  end

  def current_user
    @current_user ||= require_user
  end

  def current_admin
    current_user.try(:admin?) && current_user
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
