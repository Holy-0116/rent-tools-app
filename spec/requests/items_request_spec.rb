require 'rails_helper'

RSpec.describe "Items", type: :request do
  before do
    @item = FactoryBot.create(:item)
    @user = @item.user
    sign_in @user
  end

  describe "GET #index" do
    it "indexにアクセスすると正常にレスポンスが返ってくる" do
      get items_path
      expect(response.status).to eq 200
    end
    it "indexにアクセスすると出品された商品の金額が表示されている" do
      get items_path
      expect(response.body).to include "#{@item.price}"
    end
  end

  describe "GET #show" do
    it "出品された商品を選択すると正常にレスポンスが返ってくる" do
      get item_path(@item)
      expect(response.status).to eq 200
    end
    it "出品された商品を選択すると商品の情報が表示される" do
      get item_path(@item)
      expect(response.body).to include "#{@item.name}"
    end
  end

  describe "GET #new" do
    it "出品ページにアクセスすると正常にレスポンスが返ってくる" do
      get new_item_path
      expect(response.status).to eq 200
    end
    it "出品ページにアクセスすると正常にレスポンスが返ってくる" do
      get new_item_path
      expect(response.body).to include "商品情報入力"
    end
  end
end
