class CommentsController < ApplicationController
  before_action :set_comments
  before_action :set_item

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    @item.create_notification_comment(current_user, @comment.id) 
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def set_comments
    @comments = Comment.where(item_id: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def comment_params
    params.require(:comment)
    .permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end 
end
