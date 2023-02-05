class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin? || user == record
  end

  def create?
    user.blank?
  end

  class Scope < Scope
    def resolve
      if admin?
        scope.all
      else
        scope.where(id: user&.id)
      end
    end
  end
end
