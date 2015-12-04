class BidsController < ApplicationController
  def create
    email = params[:bid][:email]
    amount = params[:bid][:amount]

    user = User.find_by(email: email)
    product = Product.find_by(id: params[:product_id])
    bid = product.bids.new(user_id: user.id, amount: amount, product_id: product.id)

    if(bid.save)
      flash[:notice] = "Your bid was correctly send! Good luck!"
    else
      flash[:alert] = "Something went wrong"
    end

    redirect_to(user_product_path(product.user_id, product))
  end
end
