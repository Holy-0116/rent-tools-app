class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @comments = Comment.where(item_id: params[:item_id])
      @item = Item.find(params[:item_id])
    end
  end

  def destroy
    @comments = Comment.where(item_id: params[:item_id])
    @comment = Comment.find(params[:id])
    @comment.delete
    @item = Item.find(params[:item_id])
  end

  private

  def comment_params
    params.require(:comment)
    .permit(:text).merge(borrower_id: current_user.id, item_id: params[:item_id])
  end 
end
