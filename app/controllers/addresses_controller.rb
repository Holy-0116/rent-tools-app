class AddressesController < ApplicationController
before_action :address_params, only: [:create]
require "pry"
  def new
    @address = Address.new
    
  end

  def create
    binding.pry
    @user = User.find_by(id: current_user.id)
    @address = Address.new(address_params)
    if @address.valid?
      @address.save
      redirect_to edit_user_path(@user)
    else
      render :new
    end
    
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city_name, :house_number, :building_name, :phone_number).merge(user_id: current_user.id)
  end
end
