class ReviewsController < ApplicationController

  def create
    @review = Review.new(user_params) 
    product = Product.find_by_id(params[:review][:product_id])
    user = product.user
    if @review.save
      redirect_to user_product_path(user.id,product.id)
    else
      redirect_to '/'
    end
  end

  def destroy
    binding.pry
    review = Review.find_by_id(params[:review_id])
    #review.destroy
    #render status: 204
  end

private

  def user_params
     params.require(:review).permit(:description, :user_id, :product_id)
  end

end
