class SettingsController < ApplicationController

  # GET /settings/name
  def show
    setting = Setting.find_by_name(params[:name])

    render :json => setting
  end

  # PATCH/PUT /settings/name
  def update
    setting = Setting.find_by_name(params[:name])
    setting.value = params[:value]
    setting.save
    # if setting.save
    # else
      render :json => setting
    # end
  end

  private

  def setting_params
    params.permit(:name, :value)
  end
end
