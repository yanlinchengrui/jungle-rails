class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @reviews = @product.reviews.order(created_at: :desc)
    @avg = @product.reviews.average(:rating) && @product.reviews.average(:rating).round(2)
  end

end
