class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.admin?
  end

  def edit?
    user.at_least_staff?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        [record]
      end
    end
  end
end
