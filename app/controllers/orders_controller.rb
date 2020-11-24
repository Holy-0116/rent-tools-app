class OrdersController < ApplicationController
  before_action :user_signed_in?
  before_action :set_user
  before_action :set_item
  before_action :set_api_key, only: [:select_card, :set_default_card, :create_card, :create]
  before_action :get_cards, only: [:select_card, :set_default_card]

  def new
    @order = Order.new
    @address = @user.address
  end

  def create
    @order = Order.new(order_params)
    # ゲストユーザーではないか確認
    if current_user.name == 'GUEST'
      flash[:alert] = 'ゲストユーザーではレンタルできません'
      redirect_to new_item_order_path
      return
    end
    # 住所が正しいか確認
    if current_user.address == nil
      render :new
      return
    end
    # 金額が正しく表示されているか確認
    if params[:order][:price] == nil && params[:order][:price] == ""
      render :new
      return
    end
    
    # 全て正しかった場合 
    if @order.valid?
      charge_create
      @order.save
      stock = (@item.stock.to_i) - (order_params[:piece].to_i)
      @item.update(stock: stock)
      flash[:notice] = 'レンタル決済が確定しました'
      redirect_to root_path
      OrderMailer.send_when_order_create(@order).deliver
    else
      redirect_to new_item_order_path
    end
  end

  def new_card
  end

  def create_card
     # card_tokenが正しいか確認
     if params[:card_token] == nil
      flash.now[:alert] = "このカードはご利用になれません"
      render :new_card
      return
    end
    # ユーザーのcustomer_tokenが存在する場合
    if Card.find_by(user_id: current_user.id)
      card = current_user.card
      customer = Payjp::Customer.retrieve(card[0][:customer_token])
      customer.cards.create(
        card: params[:card_token]
      )
    else
    # ユーザーがcustomer_tokenが存在していない場合 
      customer = Payjp::Customer.create(
        description: "test",
        card: params[:card_token],)
    end
    # cardテーブルに保存
    card = Card.new(
      user_id: current_user.id,
      card_token: params[:card_token],
      customer_token: customer.id)
    if card.save
      redirect_to select_card_item_order_path(@item)
      flash[:notice] = "登録しました"
    else
      flash.now[:alert] = "エラーが発生しました"
      render :new_card
    end
  end

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

  def new_address
    @address = Address.new
  end

  def set_address
    @address = Address.new(address_params)
    if @address.valid?
      @address.save
      redirect_to new_item_order_path(@item)
      flash[:notice] = "登録しました"
    else
      render :new
    end
  end

  def edit_address
    @address = @user.address
  end

  def update_address
    @address = @user.address
    if @address.update(address_params)
      redirect_to new_item_order_path(@item)
      flash[:notice] = "変更しました"
    else
      render :edit_address
    end
  end


  private
  
  def user_signed_in?
    unless current_user
      redirect_to root_path
    end
  end
  
  def set_user
    @user = User.find_by(id: current_user.id)
  end

  def set_item
    @item = Item.find_by(id: params[:item_id])
  end

  def order_params
    params.require(:order).permit(:piece, :start_date, :period, :price)
    .merge(item_id:params[:item_id],borrower_id: current_user.id)
  end

  def set_api_key
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  end

  def card_params
    params.permit(:card_token, :user_id)
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

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city_name, :house_number, :building_name, :phone_number).merge(user_id: current_user.id)
  end
end
