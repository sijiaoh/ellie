module Users
  class SettingPolicy < ApplicationPolicy
    def show?
      user == record.user
    end

    def update?
      user == record.user
    end
  end
end
