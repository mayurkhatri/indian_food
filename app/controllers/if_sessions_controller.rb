class IfSessionsController < Devise::SessionsController
  def sign_in
    respond_to do |format|
      format.html
      format.js
    end
  end
end