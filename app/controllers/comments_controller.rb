class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', 
      content: [comment: @comment.text,commenter: @comment.borrower.name, date: @comment.created_at.to_s(:datetime_jp)]
    end
  end

  private

  def comment_params
    params.require(:comment)
    .permit(:text).merge(borrower_id: current_user.id, item_id: params[:item_id])
  end 
end
