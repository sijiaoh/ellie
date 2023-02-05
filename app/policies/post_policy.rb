class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user&.is_admin? || record.published? || user == record.author
  end

  def create?
    user.present?
  end

  def update?
    user&.is_admin? || user == record.author
  end

  def destroy?
    user&.is_admin? || user == record.author
  end

  class Scope < Scope
    def resolve
      if user&.is_admin?
        scope.all
      elsif user.present?
        scope.where(author: user).or(scope.published)
      else
        scope.published
      end
    end
  end
end
