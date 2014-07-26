class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource
  
  protected
  
  def layout_by_resource
    unless current_user.blank?
      if current_user.has_role? :admin
        return "admin"
      else
        return "application"
      end
    end
  end
end
