class CardsController < ApplicationController
  before_action :card_params, only: [:create]
  
  def new
  end

  def show
    if current_user.card.present? 
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      cards = Card.where(user_id: current_user.id)
      @cards = []
      cards.each do |card|
        @customer = Payjp::Customer.retrieve(card.customer_token)
        @cards << @customer.cards
      end
    else
      return
    end
  end
  

  def create
    # card_tokenが正しいか確認
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params[:card_token] == nil
      redirect_to new_user_card_path
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
      redirect_to user_card_path(current_user)
    else
      render :new
    end
  end

    private

    def card_params
      params.permit(:card_token, :user_id)
    end
  
end
