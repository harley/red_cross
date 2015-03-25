class DrivePolicy < ApplicationPolicy
  attr_accessor :user, :record
  def initialize(user, record)
    @user = user
    @record = record
  end

  def kiosk?
    user.staff? || user.admin?
  end
end
