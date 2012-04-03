class Admin::DashboardController < Admin::BaseController
  def index
    @dash = Dash::DashPresenter.new
  end
end
