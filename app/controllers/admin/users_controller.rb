class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
    @active = User.where(:banned => nil)
    @pending = User.where(:banned => nil, :sign_in_count => 0)
    @banned = User.where(:banned => true)
  end

  def new
    @user = User.new
  end

  def create

  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.attributes = params[:user]
    if @user.save
      flash[:success] = "Successfully edited user '#{@user.email}'"
      redirect_to admin_users_path
    else
      flash[:alert] = "There was an error editing user '#{@user.email}'"
      redirect_to admin_user_path(@user)
    end
  end

  def destroy

  end

  def ban
    user = User.find_by_id(params[:id])
    case user.banned
    when (nil or false)
      user.banned = true
    when true
      user.banned = false
    end
    if user.save
      flash[:success] = "Successfully #{user.banned ? nil : "un"}banned '#{user.email}'"
    else
      flash[:alert] = "There was an error trying to #{user.banned ? nil : "un"}ban '#{user.email}'"
    end
    redirect_to admin_users_path
  end
end
