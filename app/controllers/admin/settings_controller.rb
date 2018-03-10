module Admin
  class SettingsController < Admin::BaseController
    def edit
      @setting = Setting.instance
    end

    def update
      @setting = Setting.instance
      if @setting.update(setting_params)
        redirect_to edit_admin_setting_path, notice: "Settings updated"
      else
        render action: :edit
      end
    end

    private

    def setting_params
      params.require(:setting).permit(:dance_class_update_emails)
    end
  end
end
