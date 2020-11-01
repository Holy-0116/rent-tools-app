require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー管理機能" do 
    context "ユーザー登録ができる" do
      it "全ての項目が入力されていれば登録できる" do
        expect(@user).to be_valid
      end
      it "会社名がなくても登録できる(個人利用)" do
        @user.company_name = ""
        expect(@user).to be_valid
      end

    end
    context "ユーザー登録ができない" do
      it "名前が入力されていないと登録できない" do
        @user.name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it "Eメールが入力されていないと登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "入力されたEメールが既に使用されているものだったら登録できない" do
        @user = FactoryBot.create(:user)
        user = FactoryBot.build(:user)
        user.email = @user.email
        user.valid?
        expect(user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it "Eメールは@が含まれていないと登録できない" do
        @user.email = "testtest.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it "パスワードが入力されていないと登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは不正な値です", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "パスワードは半角英字だけでは登録できない" do
        @user.password = "testtest"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "パスワードは半角数字だけでは登録できない" do
        @user.password = "12345678"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "パスワード（確認用）が入力されていないと登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "パスワードとパスワード（確認用）が合っていないと登録できない" do
        @user.password_confirmation = "test12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end
    

  end

end
