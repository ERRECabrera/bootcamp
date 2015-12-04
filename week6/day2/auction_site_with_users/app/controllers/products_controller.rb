class ProductsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @products = @user.products
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @product = @user.products.find_by(id: params[:id])
    @reviews = Review.all

    if(@product.active_bid?)
      @bids = @product.bids
    else
      @winner_user = @product.get_winner_user
      @winner_bid = @product.get_winner_bid
    end
  end

  def new
    @user = User.find_by(id: params[:user_id])
    @product = @user.products.new
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @product = @user.products.new(entry_params)

    if(@product.save)
      flash[:notice] = "Product created successfully"
      redirect_to(user_products_path(@user))
    else
      flash[:alert] = "Something went wrong"
      render('new')
    end
  end

  def destroy

  end

  private

  def entry_params
    params.require(:product).permit(:title, :description, :deadline)
  end
end
