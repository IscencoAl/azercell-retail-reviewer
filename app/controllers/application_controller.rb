class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { locale: locale }
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:error] = t('views.common.not_authorized')
    redirect_to root_url
  end

  def current_user
    User.unscoped do
      super
    end
  end

  def authenticate_user!
    User.unscoped do
      super
    end
  end
end
