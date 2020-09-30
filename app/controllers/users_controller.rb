class UsersController < ApplicationController
  before_action :user_params, only: [:update]

  def show
    @user = User.find_by(id: params[:id])
  end
  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      @user = User.find_by(id: params[:id])
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit( :email, :company_name)
  end


end
