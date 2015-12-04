class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :user_name
  helper_method :product_title

  def render_404(params)
    Rails.logger.warn("Tried to access #{params} which did not exist.")
    render 'layouts/404'
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])    
  end

  def user_name(id)
    user = User.find_by_id(id)
    user.name
  end

  def product_title(id)
    product = Product.find_by_id(id)
    product.title
  end
end
