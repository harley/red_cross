class HomeController < ApplicationController
  before_action :require_user, only: [:sign_in]

  def index
    @drives = Drive.active
  end

  def sign_in
    redirect_to action: 'index'
  end
end
