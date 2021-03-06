class UsersController < ApplicationController
  before_action :user_signed_in?, only: [:show, :edit, :update]
  before_action :correct_user?, only: [:show, :edit, :update]
  before_action :user_params, only: [:update]
  

  def show
    @user = User.find_by(id: params[:id])
    @notifications = @user.passive_notifications.order(created_at: "DESC")
  end
  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.name == 'GUEST'
      redirect_to user_path(@user)
      flash[:alert] = "ゲストユーザーの名前とEmailは編集できません"
      return
    end
    if @user.update_without_password(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "変更しました"
    else
      render :edit
    end
  end

  def new_guest
    user = User.find_or_create_by!(email: Faker::Internet.free_email) do |user|
      user.password = SecureRandom.hex
      user.name = 'GUEST'
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def delete_guest
    user = User.find_by(name: 'GUEST')
    user.destroy
    redirect_to root_path, notice: 'ゲストユーザーからログアウトしました。'
  end

  private

  def user_signed_in?
    unless current_user
      redirect_to root_path
    end
  end

  def correct_user?
    @user = User.find_by(id: params[:id])
    unless @user == current_user
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit( :name, :email, :company_name)
  end


end
