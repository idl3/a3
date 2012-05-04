class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter do |c|
    c.send(:banned?, current_user)
  end

  def banned?(current_user)
    if current_user.try(:banned) and request.path != "/"
      flash[:alert] = "You are banned"
      sign_out(current_user)
      redirect_to root_path
    end
  end
end
