class SessionsController < Devise::SessionsController
  def sign_in_modal
    respond_to do |format|
      format.html
      format.js
    end
  end
end
