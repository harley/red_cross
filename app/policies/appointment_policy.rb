class AppointmentPolicy < ApplicationPolicy
  def by?
    user.staff? || user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
