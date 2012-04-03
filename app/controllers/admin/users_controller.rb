class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
    @active = User.where(:banned => false)
    @pending = User.where(:banned => false, :sign_in_count => 0)
    @banned = User.where(:banned => true)
  end

  def new

  end

  def create

  end

  def edit

  end

  def destroy

  end
end
