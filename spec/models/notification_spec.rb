require 'rails_helper'

RSpec.describe Notification, type: :model do
  before do
    @notification = FactoryBot.build(:notification)
  end

  describe "通知機能" do
    context "通知が保存されるとき" do
      it "全ての項目があれば作成される" do
        expect(@notification).to be_valid
      end
      it "comment_idがなくてもorder_idがあれば保存される" do
        @notification.comment_id = nil
        expect(@notification).to be_valid
      end
      it "order_idがなくてもcomment_idがあれば保存される" do
        @notification.order_id = nil
        expect(@notification).to be_valid
      end
      
    end
    context "通知が保存されないとき" do
      it "visitorがいないと保存されない" do
        @notification.visitor = nil
        @notification.valid?
        expect(@notification.errors.full_messages).to include("Visitorを入力してください")
      end
      it "visitedがいないと保存されない" do
        @notification.visited = nil
        @notification.valid?
        expect(@notification.errors.full_messages).to include("Visitedを入力してください")
      end
      it "itemがないと保存されない" do
        @notification.item = nil
        @notification.valid?
        expect(@notification.errors.full_messages).to include("Itemを入力してください")
      end
      it "actionがないと保存されない" do
        @notification.action = nil
        @notification.valid?
        expect(@notification.errors.full_messages).to include("Actionを入力してください")
      end
      it "comment_id,order_idどちらかがないと保存されない" do
        @notification.comment = nil
        @notification.order = nil
        @notification.valid?
        expect(@notification.errors.full_messages).to include("Comment or orderを入力してください")
      end
      it "checkedがないと保存されない" do
        @notification.checked = nil
        @notification.valid?
        expect(@notification.errors.full_messages).to include("Checkedは一覧にありません")
      end
      
    end

  end
end
