class Api::ApiController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  helper_method :current_user

  before_action :authenticate!
  rescue_from Exceptions::AuthenticationError, with: :invalid_api_key

  def current_user
    User.find(session[:current_user_id])
  end

  private

  def authenticate!
    user = authorize(params[:api_key])

    raise Exceptions::AuthenticationError unless user

    session[:current_user_id] = user.id
  end

  def invalid_api_key
    @msg = 'Invalid API Key.'

    respond_to do |format|
      format.json { render 'api/common/error' }
    end
  end

  # Helper methods

  def authorize(api_key)
    User.find_by_api_key(api_key)
  end

end
