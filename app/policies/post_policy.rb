class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.published? || user == record.author
  end

  def create?
    user.present?
  end

  def update?
    user == record.author
  end

  def destroy?
    user == record.author
  end

  class Scope < Scope
    def resolve
      if user.present?
        scope.where(author: user).or(scope.published)
      else
        scope.published
      end
    end
  end
end
