class CardsController < ApplicationController
  before_action :card_params, only: [:create]
  before_action :set_api_key, only: [:show, :create]
  before_action :user_signed_in?
  def new
  end

  def show
    if current_user.card.present? 
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
    if params[:card_token] == nil
      flash.now[:alert] = "このカードはご利用になれません"
      render :new
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
      flash[:notice] = "登録しました"
    else
      flash.now[:alert] = "エラーが発生しました"
      render :new
    end
  end

    private

    def set_api_key
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    end

    def card_params
      params.permit(:card_token, :user_id)
    end
  
    def user_signed_in?
      unless current_user
        redirect_to root_path
      end
    end
end
