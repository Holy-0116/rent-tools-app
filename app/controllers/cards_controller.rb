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
        customer = Payjp::Customer.retrieve(card.customer_token)
        @cards << customer.cards
      end
    else
      return
    end
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params[:card_token] == nil
      redirect_to new_user_card_path
      return
    end
    customer = Payjp::Customer.create(
      description: "test",
      card: params[:card_token])

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
