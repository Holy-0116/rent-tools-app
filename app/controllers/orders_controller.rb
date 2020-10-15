class OrdersController < ApplicationController
  # before_action :order_params, only: [:create]
  before_action :set_user
  before_action :set_item

  def new
    @order = Order.new
  end

  def create
    if params[:order][:price] != nil && params[:order][:price] != ""
      charge_create
    else
      redirect_to new_item_order_path
      return
    end

      order = Order.new(order_params)
      if order.valid?
        order.save
        stock = (@item.stock.to_i) - (order_params[:piece].to_i)
        @item.update(stock: stock)
        redirect_to root_path
      else
        redirect_to new_item_order_path
      end
  end


  private
  def set_user
    @user = User.find_by(id: current_user.id)
  end

  def set_item
    @item = Item.find_by(id: params[:item_id])
  end

  def order_params
    
    params.require(:order).permit(:piece, :start_date, :return_date, :period, :price)
    .merge(item_id:params[:item_id],borrower_id: current_user.id, lender_id: Item.find_by(id:params[:item_id]).user_id)
  end

  def charge_create
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      card = Card.find_by(user_id: current_user.id)
      customer = Payjp::Customer.retrieve(card.customer_token)
      Payjp::Charge.create(
        :amount => params[:order][:price],
        :customer => customer.id,
        :currency => 'jpy') 
  end
end
