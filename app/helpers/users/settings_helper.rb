module Users
  module SettingsHelper
    def user_setting_link(setting)
      button_link_primary t("detail"), user_setting_path(setting.user) if policy(setting).show?
    end

    def edit_user_setting_link(setting)
      button_link_primary t("edit"), edit_user_setting_path(setting.user) if policy(setting).edit?
    end
  end
end
