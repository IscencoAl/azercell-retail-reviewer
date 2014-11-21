class Api::UsersController < Api::ApiController
  skip_before_action :authenticate!

  # POST /api/users/sign_in
  def sign_in
    begin
      @api_key = get_api_key(params[:email], params[:password])
    rescue Exception => ex
      @msg = ex.message
      render 'api/common/error'
    end
  end

  # Helper methods

  def get_api_key(email, password)
    user = User.find_by_email(email)

    return user.api_key if user and user.valid_password?(password)
    raise StandardError, 'Invalid email or password.'
  end

end