class UsersController < ApplicationController


  def index
    @users = User.all
    render "index"
  end

  def show
    @user = User.find(params[:id])
    @products = @user.products
    render "show"
  end

  def create
    @new_user = User.new(entry_params)
    if @new_user.save
      flash[:notice] = "User Added"
      redirect_to action: "show", controller: "users", id: @new_user.id
      #redirect_to user_path(@new_user.id)
    else
      flash[:alert] = "Problem with process"
      render "new"
    end
    
  end

  def new
    @new_user = User.new
    render "new"
  end

  def destroy
    
  end

private

  def entry_params
    params.require(:user).permit(:name, :email)
  end

end
