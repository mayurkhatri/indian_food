class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied"
    redirect_to root_url
  end

  def set_locale
    I18n.locale = :en
  end
end
