class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html
        format.js
      end
    else
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, picture_id: params[:picture_id])
  end

  def set_picture
    @picture = Picture.find(params[:picture_id])
    @comment_block = "#comment-block-#{@picture.id}"
    @comment_block_2 = "#comment-block-2-#{@picture.id}"
    @new_comment = "#new-comment-#{@picture.id}"
  end
end
