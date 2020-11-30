require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe "コメント投稿機能" do
    context "コメントが投稿できるとき" do
      it "テキストがあれば投稿できる" do
        expect(@comment).to be_valid 
      end
    end

    context "コメントが投稿できないとき" do
      it "テキストが入力されていないと投稿できない" do
        @comment.text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Textを入力してください")
      end
      it "コメント内容が121文字以上は投稿できない" do
        length121 = ""
        121.times do
          length121 += "a"
        end
        @comment.text = length121
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Textは120文字以内で入力してください")
      end
      it "ログインしていないと投稿できない" do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Userを入力してください")
      end
    end  
  end
end
