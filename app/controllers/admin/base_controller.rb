class Admin::BaseController < ApplicationController
  before_action :require_access_level
  @access_level = 'admin'

  def require_access_level
    unless (current_user && current_user.has_role?(self.class.access_level))
      render status: 403, text: "Access Denied"
    end
  end

  def self.access_level
    @access_level
  end
end
