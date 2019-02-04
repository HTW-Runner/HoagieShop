class CommentsController < ApplicationController
  def create
    if session[:customer_id].nil?
      redirect_to login_path
    else
      @review = Review.find(params[:review_id])
      @comment = @review.comments.create(comment_params)
      @comment.update(customer_id: session[:customer_id])
      redirect_to review_path(@review)
    end
  end

  def destroy
    if session[:customer_id].nil?
      redirect_to login_path
    else
      @review = Review.find(params[:review_id])
      @comment = @review.comments.find(params[:id])
      if session[:customer_id].to_i == @comment.customer_id.to_i
        @comment.destroy
      end
      redirect_to review_path(@review)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:customer_id, :text)
  end
end
