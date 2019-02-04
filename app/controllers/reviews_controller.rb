class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
    @customer = Customer.find(@review.customer_id)
  end

  def edit
    if session[:customer_id].nil?
      redirect_to login_path
    else
      @review = Review.find(params[:id])
      if session[:customer_id].to_i != @review.customer_id.to_i
        redirect_to review_path
      end
    end
  end

  def new
    if session[:customer_id].nil?
      redirect_to login_path
    else
      @review = Review.new      
    end
  end

  def create
    @review = Review.new(review_params)
    @review.update(customer_id: session[:customer_id])
    if @review.save
      redirect_to @review
    else
      render 'new'
    end
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to @review
    else
      render 'edit'
    end
  end

  def destroy
    if session[:customer_id].nil?
      redirect_to login_path
    else
      @review = Review.find(params[:id])
      if session[:customer_id].to_i == @review.customer_id.to_i
        @review.destroy
        redirect_to reviews_path
      else
        redirect_to review_path
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:customer_id, :title, :text, :grade, :selfie)
  end
end
