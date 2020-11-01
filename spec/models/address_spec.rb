require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end

  describe "住所登録機能" do
    context "住所登録ができるとき" do
      it "全ての情報が入力されていれば登録できる" do
        expect(@address).to be_valid 
      end
      it "建物名がなくても登録できる" do
        @address.building_name = nil
        expect(@address).to be_valid 
      end
    end

    context "住所登録できないとき" do
      it "郵便番号がないと登録できない" do
        @address.postal_code = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号はハイフンなしの半角数字(7桁)を入力してください")
      end
      it "郵便番号は全角数字だと登録できない" do
        @address.postal_code = "１２３４５６７"
        @address.valid?
        expect(@address.errors.full_messages).to include("郵便番号はハイフンなしの半角数字(7桁)を入力してください")
      end
      it "郵便番号はハイフンが含まれていると登録できない" do
      end
      it "都道府県が選択されていないと登録できない" do
        @address.prefecture_id = "0"
        @address.valid?
        expect(@address.errors.full_messages).to include("都道府県を選んでください")
      end
      it "市区町村名がないと登録できない" do
        @address.city_name = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("市区町村を入力してください")
      end
      it "番地がないと登録できない" do
        @address.house_number = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("番地を入力してください")
      end
      it "電話番号がないと登録できない" do
        @address.phone_number = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("電話番号を入力してください", "電話番号はハイフンなしの半角数字（10~11桁）を入力してください")
      end
      it "電話番号は全角数字だと登録できない" do
        @address.phone_number = "０１２３４５６７８９"
        @address.valid?
        expect(@address.errors.full_messages).to include("電話番号はハイフンなしの半角数字（10~11桁）を入力してください")
      end
      it "電話番号はハイフンが含まれていると登録できない" do
        @address.phone_number = "000-0000-0000"
        @address.valid?
        expect(@address.errors.full_messages).to include("電話番号はハイフンなしの半角数字（10~11桁）を入力してください")
      end
    end
  end

end
