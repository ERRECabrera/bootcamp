class UsersController < ApplicationController
  def index
    @users = User.all.order("name ASC")
  end

  def show
    @users = [current_user]
    @reviews = current_user.reviews
  end

  def new
    @user = User.new
  end

  def destroy

  end

  def create
    @user = User.new(entry_params)

    if(@user.save)
      flash[:notice] = "User created successfully!"
      redirect_to(users_path)
    else
      flash[:alert] = "Something went wrong"
      render('new')
    end
  end

  private

  def entry_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
