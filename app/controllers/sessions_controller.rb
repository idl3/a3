class SessionsController < Devise::SessionsController
  layout "login"
  def destroy
    super
    reset_session
  end
end
