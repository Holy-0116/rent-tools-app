require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @borrower = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order)
    @order.borrower = @borrower
    @order.item = @item
  end

  describe "決済機能" do
    context "決済ができるとき" do
      it "全ての入力されていたら決済できる" do
        expect(@order).to be_valid
      end
    end
    context "決済ができないとき" do
      it "レンタルする個数がないと決済できない" do
        @order.piece = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Piece can't be blank")
      end
      it "レンタル開始日がないと決済できない" do
        @order.start_date = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Start date can't be blank")
      end
      it "レンタル開始日が過去の日付だと決済できない" do
        @order.start_date = '1900-01-01'
        @order.valid?
        expect(@order.errors.full_messages).to include("Start date can't select Past")
      end
      it "レンタル開始日がないと決済できない" do
        @order.period = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Period can't be blank")
      end
      

    end

  end

end
