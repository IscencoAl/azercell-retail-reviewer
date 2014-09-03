class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { locale: locale }
  end

  rescue_from CanCan::AccessDenied do |exception|
    render 'layouts/access_denied'
  end
end
