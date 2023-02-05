module Users
  class SettingPolicy < ApplicationPolicy
    def show?
      admin? || user == record.user
    end

    def update?
      admin? || user == record.user
    end
  end
end
