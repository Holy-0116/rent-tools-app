require 'rails_helper'

RSpec.describe "Orders", type: :request do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET #new" do
    it "商品決済ページにアクセスすると正常にレスポンスが返ってくる" do
      get new_item_order_path(@item)
      expect(response.status).to eq 200
    end
    it "商品決済ページにアクセスすると「レンタル申込フォーム」の文字が存在する" do
      get new_item_order_path(@item)
      expect(response.body).to include "レンタル申込フォーム"
    end
    it "商品決済ページにアクセスすると対象の商品の名前が存在する" do
      get new_item_order_path(@item)
      expect(response.body).to include "#{@item.name}"
    end
  end

  describe "GET #select_card_item_order" do
    it "クレジットカード選択ページにアクセスすると正常にレスポンスが返ってくる" do
      get select_card_item_order_path(@item)
      expect(response.status).to eq 200
    end
  end
  
  describe "GET #new_card_item_order" do
    it "決済前のクレジットカード選択ページから新規カード登録画面にアクセスすると正常にレスポンスが返ってくる" do
      get new_card_item_order_path(@item)
      expect(response.status).to eq 200
    end
    it "決済前のクレジットカード選択ページから新規カード登録画面にアクセスすると「カード情報」の文字が存在する" do
      get new_card_item_order_path(@item)
      expect(response.body).to include "カード情報"
    end
  end

  describe "GET #new_address_item_order" do
    it "レンタル申込フォームから住所登録ページにアクセスすると正常にレスポンスが返ってくる" do
      get new_address_item_order_path(@item)
      expect(response.status).to eq 200
    end
    it "レンタル申込フォームから住所登録ページにアクセスすると「住所登録」の文字が存在する" do
      get new_address_item_order_path(@item)
      expect(response.body).to include "住所登録"
    end
  end

  describe "GET #edit_address_item_order" do
    it "レンタル申込フォームから住所編集ページにアクセスすると正常にレスポンスが返ってくる" do
      @user.address = FactoryBot.create(:address)
      get edit_address_item_order_path(@item)
      expect(response.status).to eq 200
    end
  

    it "レンタル申込フォームから住所編集ページにアクセスすると「住所登録」の文字が存在する" do
      @user.address = FactoryBot.create(:address)
      get edit_address_item_order_path(@item)
      expect(response.body).to include "住所登録"
    end
  end

end
