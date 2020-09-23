class ItemsController < ApplicationController
  def index
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

  def item_params
    params.require(:item)
    .permit(:name, :image, :explanation, :size, :status_id, :delivery_fee_id, :delivery_date_id, :price)
  end
end

