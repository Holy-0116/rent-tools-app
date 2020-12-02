require 'rails_helper'

RSpec.describe "Addresses", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET #new" do
    it "住所登録ページにアクセスすると正常にレスポンスが返ってくる" do
      get new_user_address_path(@user)
      expect(response.status).to eq 200
    end
    it "住所登録ページにアクセスすると「住所登録」の文字が存在する" do
      get new_user_address_path(@user)
      expect(response.body).to include "住所登録"
    end
  end

  describe "GET #edit" do
    it "住所編集ページにアクセスすると正常にレスポンスが返ってくる" do
      @user.address = FactoryBot.create(:address)
      get edit_user_address_path(@user)
      expect(response.status).to eq 200
    end
    it "住所編集ページにアクセスすると登録されたユーザーの住所情報が存在する" do
      @user.address = FactoryBot.create(:address)
      get edit_user_address_path(@user)
      expect(response.body).to include "#{@user.address.postal_code}"
    end
  end
end
