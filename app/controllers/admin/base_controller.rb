class Admin::BaseController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin?
  layout "admin"

  def is_admin?
    flash[:alert] = "You are not and administrator" and redirect_to root_path unless current_user.admin?
  end
end
