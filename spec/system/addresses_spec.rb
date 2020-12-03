require 'rails_helper'

RSpec.describe "住所登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @address = FactoryBot.build(:address)
  end
  
  context "住所が登録できるとき" do
    it "ログインしたユーザーは正しい情報を入力すれば住所が登録でき、ユーザー詳細ページに遷移する" do
      # ログインする
      sign_in @user
      # ユーザー詳細ページへ移動する
      visit user_path(@user)
      # 住所登録ボタンが表示されていることを確認する
      expect(page).to have_content("住所登録")
      # 住所登録ページに移動する
      visit new_user_address_path(@user)
      # 入力フォームに正しい住所情報を入力する
      fill_in "郵便番号(半角数字・ハイフンなし)", with: @address.postal_code
      select(value= @address.prefecture.name, from: 'address_prefecture_id')
      fill_in "市区町村", with: @address.city_name
      fill_in "番地", with: @address.house_number
      fill_in "建物名", with: @address.building_name
      fill_in "電話番号(半角数字・ハイフンなし)", with: @address.phone_number
      # 登録ボタンを押すと、Addressモデルのカウントが１増えることを確認する
      expect{ click_on("登録する")}.to change{ Address.count}.by(1)
      # ユーザー編集ページに遷移していることを確認する
      expect(current_path).to eq edit_user_path(@user)
      # 登録した住所情報が表示されていることを確認する
      expect(page).to have_content(@address.postal_code)
    end
  end
  context "住所が登録できないとき" do
    it "ログインしたユーザーでも誤った情報を入力すれば住所が登録できす、住所登録ページに戻ってくる" do
      # ログインする
      sign_in @user
      # ユーザー詳細ページへ移動する
      visit user_path(@user)
      # 住所登録ボタンが表示されていることを確認する
      expect(page).to have_content("住所登録")
      # 住所登録ページに移動する
      visit new_user_address_path(@user)
      # 入力フォームに誤った住所情報を入力する
      fill_in "郵便番号(半角数字・ハイフンなし)", with: ""
      select(value= "選択してください", from: 'address_prefecture_id')
      fill_in "市区町村", with: ""
      fill_in "番地", with: ""
      fill_in "建物名", with: ""
      fill_in "電話番号(半角数字・ハイフンなし)", with: ""
      # 登録ボタンを押すと、Addressモデルのカウントが上がらないことを確認する
      expect{ click_on("登録する")}.to change{ Address.count}.by(0)
      # 住所登録ページに戻ってくることを確認する
      expect(current_path).to eq "/users/#{@user.id}/address"
    end
    it "ログインしたユーザーでも別のユーザーの住所登録ページに移動できず、商品一覧ページに遷移する" do
      # 別のユーザーを作成
      another_user = FactoryBot.create(:user)
      # ログインする
      sign_in another_user
      # @userの住所登録ページに移動する
      visit new_user_address_path(@user)
      # 商品一覧ページに遷移していることを確認する
      expect(current_path).to eq items_path
    end
  end
end

RSpec.describe "住所編集", type: :system do
  before do
    @address = FactoryBot.create(:address)
    @user = @address.user
  end

  context "住所が編集できるとき" do
    it "ログインしたユーザーは正しい情報を入力すれば住所が編集でき、ユーザー詳細ページに遷移する" do
      # ログインする
      sign_in @user
      # ユーザー詳細ページへ移動する
      visit user_path(@user)
      # 住所変更ボタンが表示されていることを確認する
      expect(page).to have_content("住所変更")
      # 住所変更ページに移動する
      visit edit_user_address_path(@user)
      # 入力フォームに登録された住所情報（郵便番号）が表示されていることを確認する
      expect(find('input[id="address_postal_code"]').value).to eq @address.postal_code
      # 入力フォームに別の正しい住所情報（郵便番号）を入力する
      fill_in "郵便番号(半角数字・ハイフンなし)", with: "1234567"
      # 変更ボタンを押すと、住所情報が変更されていることを確認する
      expect{click_on("変更する")}.to change{ Address.find(@address.id).postal_code}.from(@address.postal_code).to("1234567")
      # ユーザー編集ページに遷移していることを確認する
      expect(current_path).to eq edit_user_path(@user)
      # 変更した住所情報が表示されていることを確認する
      expect(page).to have_content("1234567")
    end
  end
  context "住所が登録できないとき" do
    it "ログインしたユーザーでも誤った情報を入力すれば住所が編集できす、住所編集ページに戻ってくる" do
      # ログインする
      sign_in @user
      # ユーザー詳細ページへ移動する
      visit user_path(@user)
      # 住所変更ボタンが表示されていることを確認する
      expect(page).to have_content("住所変更")
      # 住所変更ページに移動する
      visit edit_user_address_path(@user)
      # 入力フォームに登録された住所情報が表示されていることを確認する
      expect(find('input[id="address_postal_code"]').value).to eq @address.postal_code
      # 入力フォームに別の誤った住所情報を入力する
      fill_in "郵便番号(半角数字・ハイフンなし)", with: ""
      # 変更ボタンを押す
      click_on("変更する")
      # 住所編集ページに戻ってくることを確認する
      expect(current_path).to eq "/users/#{@user.id}/address"
    end
    it "ログインしたユーザーでも別のユーザーの住所編集ページに移動できず、商品一覧ページに遷移する" do
      # 別のユーザーを作成
      another_user = FactoryBot.create(:user)
      # ログインする
      sign_in another_user
      # @userの住所編集ページに移動する
      visit edit_user_address_path(@user)
      # 商品一覧ページに遷移していることを確認する
      expect(current_path).to eq items_path
    end
  end
end