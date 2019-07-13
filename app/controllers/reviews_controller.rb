class ReviewsController < ApplicationController

  before_filter :authorize

  def create
    @product = Product.find(params[:product_id])
    review = @product.reviews.create(
      user: current_user, 
      description: review_params[:description], 
      rating: review_params[:rating]
    )
    review.save
    redirect_to @product
  end

  def destroy
    @product = Product.find(params[:product_id])
    review = @product.reviews.find(params[:id])
    review.destroy
    redirect_to @product
  end

  private
  def review_params
    params.require(:review).permit(:description, :rating)
  end

end
