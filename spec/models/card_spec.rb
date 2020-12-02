require 'rails_helper'

RSpec.describe Card, type: :model do
  before do
    @card = FactoryBot.build(:card)
  end

  describe "クレジットカード情報登録機能" do
    context "クレジットカード情報が登録できるとき" do
      it "全ての値があれば登録できる" do
        expect(@card).to be_valid
      end
    end

    context "クレジットカード情報が登録できないとき" do
      it "ユーザーがいないと登録できない" do
        @card.user = nil
        @card.valid?
        expect(@card.errors.full_messages).to include("Userを入力してください")
      end
      it "card_tokenがないと登録できない" do
        @card.card_token= nil
        @card.valid?
        expect(@card.errors.full_messages).to include("Card tokenを入力してください")
      end
      it "customer_tokenがないと登録できない" do
        @card.customer_token = nil
        @card.valid?
        expect(@card.errors.full_messages).to include("Customer tokenを入力してください")
      end
    end
  end
end
