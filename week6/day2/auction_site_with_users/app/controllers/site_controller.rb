class SiteController < ApplicationController
  def home
    @products = Product.all
  end
end
