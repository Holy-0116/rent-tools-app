require 'rails_helper'

RSpec.describe Item, type: :model do
  before do 
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/images/test_image.png')
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
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "商品の画像がないと出品できない" do
        @item.image =nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "商品の説明がないと出品できない" do
        @item.explanation =nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it "商品のサイズがないと出品できない" do
        @item.size =""
        @item.valid?
        expect(@item.errors.full_messages).to include("Size can't be blank")
      end
      it "商品のカテゴリーが選択されていないと出品できない" do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category select!")
      end
      it "商品の状態が選択されていないと出品できない" do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Status select!")
      end
      it "商品の発送までの日数が選択されていないと出品できない" do
        @item.delivery_date_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery date select!")
      end
      it "商品の配送負担が選択されていないと出品できない" do
        @item.delivery_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee select!")
      end
      it "商品の金額がないと出品できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price invalid. Price is half-width number","Price can't be blank")
      end
      it "商品の金額がないと出品できない" do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
    
      end

    end
  end
end
