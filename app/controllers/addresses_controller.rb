class AddressesController < ApplicationController
  before_action :signed_in_user?
  before_action :correct_user?
  before_action :address_params, only: [:create, :update]

  def new
    @address = Address.new
    
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @address = Address.new(address_params)
    if @address.valid?
      @address.save
      redirect_to edit_user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @address = @user.address
  end

  def update
    @user = User.find_by(id: params[:user_id])
    if @address = Address.update(address_params)
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  private
  def signed_in_user?
    unless current_user
      redirect_to root_path
    end
  end

  def correct_user?
    @user = User.find_by(id: params[:user_id])
    unless @user == current_user
      redirect_to root_path
    end
  end

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city_name, :house_number, :building_name, :phone_number).merge(user_id: current_user.id)
  end
end
