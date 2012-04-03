class PasswordsController < Devise::PasswordsController
  before_filter :sign_in?, :except => [:new]
  layout "login"

  private

  def sign_in?
    unless user_signed_in?
      flash[:alert] = "You are not signed in"
      redirect_to root_path
    end
  end
end
