class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource
  
  protected
  
  def layout_by_resource
    unless current_user.blank?
      if current_user.has_role? :admin
        puts "========>>>>> In layout_by_resource admin if block"
        return "admin"
      else
        puts "========>>>>> In layout_by_resource admin else block"
        return "application"
      end
    end
  end
end
