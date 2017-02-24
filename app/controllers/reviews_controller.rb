class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.build(review_params)
    
    if @review.save
      redirect_do @review.room, notice: "댓글을 등록했어요!"
    else
      redirect_do @review.room, alert: "댓글 내용을 입력하세요!"
    end
    
  end

  def destroy
    @review = Review.find(params[:id])
    room = @review.room
    @review.destroy

    redirect_do room, notice: "댓글을 삭제했습니다."
  end

  private
  def review_params
    params.require(:review).permit(
      :comment, 
      :cleanliness, 
      :location, 
      :accuracy, 
      :value, 
      :room_id
    )
  end
end
