class ApplicationController < ActionController::Base
  before_filter :fix_cas_session
  before_action :require_user
  helper_method :current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
      @current_user ||= User.where(netid: session[:cas][:user], session: session[:cas].to_json).first_or_create!
    end
  end

  def skip_login?
    false
  end

  def current_user
    @current_user ||= require_user
  end
end
