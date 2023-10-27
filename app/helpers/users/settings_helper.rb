module Users
  module SettingsHelper
    def user_setting_btn_link(setting)
      btn_to t("detail"), user_setting_path(setting.user), type: :link if policy(setting).show?
    end

    def edit_user_setting_btn_link(setting)
      btn_to t("edit"), edit_user_setting_path(setting.user), type: :link if policy(setting).edit?
    end
  end
end
