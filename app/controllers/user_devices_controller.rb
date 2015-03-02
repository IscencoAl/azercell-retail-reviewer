class UserDevicesController < ApplicationController

  before_action :load_user, only: [:destroy]
  def index
    @user_devices = policy_scope(UserDevice)
    @user_devices = @user_devices.all
  end

  # DELETE /user_devices/1
  def destroy
    @user_device.destroy
    lash[:success] = t('controllers.user_devices.destroyed', name: @user_device.user.full_name)
    redirect_to request.referer
  end

  private

  def load_user
    @user_device = UserDevice.find(params[:id])
  end
end
