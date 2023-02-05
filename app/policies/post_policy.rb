class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    admin? || record.published? || user == record.author
  end

  def create?
    user.present?
  end

  def update?
    admin? || user == record.author
  end

  def destroy?
    admin? || user == record.author
  end

  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif user.present?
        scope.where(author: user).or(scope.published)
      else
        scope.published
      end
    end
  end
end
