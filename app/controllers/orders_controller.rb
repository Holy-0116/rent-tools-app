class OrdersController < ApplicationController
  before_action :set_user
  before_action :set_item
  before_action :set_api_key, only: [:select_card, :set_default_card, :create]
  before_action :get_cards, only: [:select_card, :set_default_card]

  def select_card
    if current_user.card.present? 
      get_cards
    else
      return
    end
  end

  def set_default_card
    if current_user.card.present? 
      get_cards
    else
      render :select_card
      return
    end
    
    index = params[:selected].to_i
    @customer[:default_card] = @cards[0].data[index][:id]
    @customer.save
    redirect_to new_item_order_path
  end

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

  def set_api_key
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  end

  def get_cards
    cards = Card.where(user_id: current_user.id)
      @cards = []
      cards.each do |card|
        @customer = Payjp::Customer.retrieve(card.customer_token)
        @cards << @customer.cards
      end
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
