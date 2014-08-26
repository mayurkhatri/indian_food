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

  def check_role
    if (!current_user.has_role? :admin) || (!current_user.has_role? :moderator)
      raise CanCan::AccessDenied
    end
  end
end
