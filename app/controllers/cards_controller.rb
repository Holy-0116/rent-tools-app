class CardsController < ApplicationController
  before_action :card_params, only: [:create]
  
  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params[:card_token] == nil
      render :new
      return
    end
    customer = Payjp::Customer.create(
      description: "test",
      card: params[:card_token])

    card = Card.new(
      user_id: current_user.id,
      card_token: params[:card_token],
      customer_token: customer.id)
      binding.pry
    if card.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

    private

    def card_params
      params.permit(:card_token, :user_id)
    end
  
end
