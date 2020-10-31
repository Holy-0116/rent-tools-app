class ItemsController < ApplicationController
  before_action :signed_in?, only: [:new, :create]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :item_user?, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order(created_at: "DESC")
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
      flash[:notice] = "登録しました"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    binding.pry
    if @item.update(item_params)
      redirect_to item_path(@item)
      flash[:notice] = "変更しました"
    else 
      render "edit"
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
    flash[:notice] = "削除しました"
  end

  private
  def signed_in?
    unless current_user
      redirect_to user_session_path
    end
  end

  def set_item
    @item = Item.find_by(id: params[:id])
  end

  def item_user?
    unless @item.user == current_user
      redirect_to root_path
    end
  end

  def item_params
    params.require(:item)
    .permit(:name, :image, :explanation, :size, :category_id, :status_id, :delivery_fee_id, :delivery_date_id, :stock, :price).merge(user_id: current_user.id)
  end
end

