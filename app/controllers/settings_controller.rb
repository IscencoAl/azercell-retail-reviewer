class SettingsController < ApplicationController
  before_action :load_setting, only: [:edit, :update]

  # GET /settings
  def index
    @settings = policy_scope(Setting)
  end

  # GET /settings/1
  def edit
    session[:return_to] = request.referer unless request.referer == request.url
  end
  
  # PATCH/PUT /settings/1
  def update
    if @setting.update(setting_params)
      flash[:success] = t('controllers.settings.updated', name: @setting.name)
      redirect_to session.delete(:return_to) || settings_url
    else
      render :edit
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:name, :value)
  end

  def load_setting
    @setting = Setting.find(params[:id])
  end
end
