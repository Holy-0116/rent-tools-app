require 'rails_helper'

RSpec.describe Item, type: :model do
  before do 
    @item = FactoryBot.build(:item)
  end

  describe "出品機能" do
    context "出品できるとき" do
      it "全ての項目が入力できていれば出品できる" do
        expect(@item).to be_valid
      end
    end

    context "出品できないとき" do
      it "商品名がないと出品できない" do
        @item.name =""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it "商品の画像がないと出品できない" do
        @item.image =nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it "商品の説明がないと出品できない" do
        @item.explanation =nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品説明を入力してください")
      end
      it "商品のサイズがないと出品できない" do
        @item.size =""
        @item.valid?
        expect(@item.errors.full_messages).to include("サイズを入力してください")
      end
      it "商品のカテゴリーが選択されていないと出品できない" do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選んでください")
      end
      it "商品の状態が選択されていないと出品できない" do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品状態を選んでください")
      end
      it "商品の発送までの日数が選択されていないと出品できない" do
        @item.delivery_date_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選んでください")
      end
      it "商品の配送負担が選択されていないと出品できない" do
        @item.delivery_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送費負担を選んでください")
      end
      it "商品の在庫がいないと出品できない" do
        @item.stock = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("在庫を入力してください", "在庫は数値で入力してください")
      end
      it "商品の金額がないと出品できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("金額を入力してください", "金額金額が表示されていません", "金額は数値で入力してください")
      end
      it "商品の金額がないと出品できない" do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("金額は数値で入力してください")
    
      end

    end
  end
end
