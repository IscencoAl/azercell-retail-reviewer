class Api::UsersController < Api::ApiController
  skip_before_action :authenticate!

  # POST /api/users/sign_in
  def sign_in
    begin
      user = get_user(params[:email], params[:password])
      check_device(user, params[:device_id]) unless Setting.max_user_devices_count == 0

      @api_key = user.api_key
    rescue Exception => ex
      @msg = ex.message
      render 'api/common/error'
    end
  end

  # Helper methods

  def get_user(email, password)
    user = User.find_by_email(email)

    return user if user and user.valid_password?(password)
    raise StandardError, 'Invalid email or password.'
  end

  def check_device(user, device_id)
    device = user.device

    if device
      raise StandardError, 'You are associated with another device' unless device.device_id == device_id
    else
      device = user.build_device(device_id: device_id)
      unless device.save
        raise StandardError, device.errors.full_messages.join('; ')
      end
    end
  end

end