class BidsController < ApplicationController

  def create
    binding.pry
    @user = User.find(params[:user_id])
    @product = Product.find(params[:product_id])
    @new_bid = @product.bids.new(entry_params)
    @new_
  end

private

  def entry_params
    params.require(:bid).permit(:product_id, :amount, :email)
  end

end
