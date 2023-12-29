module Users
  class SettingsController < ApplicationController
    skip_after_action :verify_policy_scoped

    before_action :set_setting, only: %i[show edit update]

    def show; end

    def edit; end

    def update
      if @setting.update(setting_params)
        redirect_to user_setting_path(@setting.user), notice: notice_message(Setting)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_setting
      user = User.find(params[:user_id])
      @setting = authorize(user.setting)
    end

    def setting_params
      params.require(:users_setting).permit(:editor_type)
    end
  end
end
