class ItemsController < ApplicationController
  before_action :signed_in?, only: [:new, :create]

  def index
    @items = Item.all.order(created_at: "DESC")
  end

  def show
    @item = Item.find_by(id: params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render "new"
    end
  end

  private
  def signed_in?
    unless current_user
      redirect_to user_session_path
    end
  end

  def item_params
    params.require(:item)
    .permit(:name, :image, :explanation, :size, :category_id, :status_id, :delivery_fee_id, :delivery_date_id, :price).merge(user_id: current_user.id)
  end
end

