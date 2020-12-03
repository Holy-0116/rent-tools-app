require 'rails_helper'

RSpec.describe "商品登録", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.user = @user
    @image_path = Rails.root.join('public/images/test_image.png')
  end
  
  context "商品が出品できるとき" do
    it "ログインしたユーザーは正しい情報を入力すれば商品を出品でき、商品一覧ページに遷移する" do
      # ログインする
      sign_in @user
      # 出品ページに移動する
      visit new_item_path
      # 入力フォームに商品情報を入力する
      fill_in "商品名", with: @item.name
      attach_file('item[image]', @image_path)
      fill_in "商品の説明", with: @item.explanation
      fill_in "サイズ", with: @item.size
      select(value= @item.category.name, from: 'item_category_id') 
      select(value= @item.status.name, from: 'item_status_id') 
      select(value= @item.delivery_date.name, from: 'item_delivery_date_id') 
      select(value= @item.delivery_fee.name, from: 'item_delivery_fee_id') 
      fill_in "在庫数", with: @item.stock
      fill_in "１週間のレンタル価格（単価）", with: @item.price
      # 出品するボタンを押すとItemモデルのカウントが１上がることを確認する
      expect{ click_on("出品する")}.to change{ Item.count}.by(1)
      # 商品一覧ページに遷移していることを確認する
      expect(current_path).to eq items_path
      # 商品一覧ページに出品した商品の画像が表示されていることを確認する
      expect(page).to have_selector('img[src$="test_image.png"]')
    end
  end

  context "商品が出品できないとき" do
    it "ログインしたユーザーは誤った情報を入力すると商品を出品できず、出品ページに戻ってくる" do
      # ログインする
      sign_in @user
      # 出品ページに移動する
      visit new_item_path
      # 入力フォームに商品情報を入力する
      fill_in "商品名", with: ""
      fill_in "商品の説明", with: ""
      fill_in "サイズ", with: @item.size
      select(value= "選択してください", from: 'item_category_id') 
      select(value= "選択してください", from: 'item_status_id') 
      select(value= "選択してください", from: 'item_delivery_date_id') 
      select(value= "選択してください", from: 'item_delivery_fee_id') 
      fill_in "在庫数", with: ""
      fill_in "１週間のレンタル価格（単価）", with: ""
      # 出品ボタンを押してもItemモデルのカウントは上がらないことを確認する
      expect{ click_on("出品する")}.to change{ Item.count}.by(0)
      # 出品ページに戻っていることを確認する
      expect(current_path).to eq "/items"
    end
    it "ログインしてないユーザーは出品ページに遷移できず、トップページに戻ってくる" do
      # ログインせずに出品ページに移動する
      visit new_item_path
      # トップページに戻っていることを確認する
      expect(current_path).to eq root_path
      # 出品するボタンがないことを確認する
      expect(page).to have_no_content("出品する")
    end
  end
end

RSpec.describe "商品編集", type: :system do
  before do
    @item = FactoryBot.create(:item)
    @user = @item.user
  end

  context "商品が編集できるとき" do
    it "出品したユーザーが、正しい情報が入力すれば更新されてページに遷移する" do
      # ログインする
      sign_in @user
      # 商品詳細ページに移動する
      visit item_path(@item)
      # 編集ボタンが表示されていることを確認する
      expect(page).to have_content( "編集")
      # 編集ページに移動する
      visit edit_item_path(@item)
      # 登録時の商品の情報が表示されていることを確認する
      expect(page).to have_content(@item.name)
      # 入力フォームに商品情報（金額）を入力する
      fill_in "１週間のレンタル価格（単価）", with: @item.price.to_i + 100
      # 再出品するボタンを押すと商品の情報が更新される
      expect{ click_on("出品する")}.to change{ Item.find(@item.id).price}.from(@item.price).to(@item.price.to_i + 100)
      # 商品詳細ページに遷移していることを確認する
      expect(current_path).to eq item_path(@item)
      # 商品詳細ページに更新した情報（金額）が表示されていることを確認する
      expect(page).to have_content(@item.price.to_i + 100)
    end
  end

  context "商品が編集できないとき" do
    it "出品したユーザーであっても、誤った情報を入力すれば更新されず編集ページに戻ってくる" do
      # ログインする
      sign_in @user
      # 商品詳細ページに移動する
      visit item_path(@item)
      # 編集ボタンが表示されていることを確認する
      expect(page).to have_content( "編集")
      # 編集ページに移動する
      visit edit_item_path(@item)
      # 登録時の商品の情報が表示されていることを確認する
      expect(page).to have_content(@item.name)
      # 入力フォームに商品情報（金額）を入力する
      fill_in "１週間のレンタル価格（単価）", with: ""
      # 再出品するボタンを押す
      click_on("出品する")
      # 編集ページに戻っていることを確認する
      expect(current_path).to eq "/items/#{@item.id}"
    end
    it "ログインしていても出品したユーザーでなければ編集はできず、商品一覧ページに遷移される" do
      # 出品者とは別のユーザーを作成
      another_user = FactoryBot.create(:user)
      # ログインする
      sign_in another_user
      # 商品詳細ページに移動する
      visit item_path(@item)
      # 編集ボタンが表示されていないことを確認する
      expect(page).to have_no_content("編集")
      # 編集ページへ移動する
      visit edit_item_path(@item)
      # 編集ページではなく商品一覧ページへ遷移していることを確認する
      expect(current_path).to eq items_path
    end
  end
end

RSpec.describe "商品削除", type: :system do
  before do
    @item = FactoryBot.create(:item)
    @user = @item.user
  end

  context "商品が削除できるとき" do
    it "出品したユーザーが、商品削除ボタンを押せば削除され、商品一覧ページに遷移する" do
      # ログインする
      sign_in @user
      # 商品詳細ページに移動する
      visit item_path(@item)
      # 削除ボタンが表示されていることを確認する
      expect(page).to have_content( "削除")
      # 削除ボタンを押すとItemのカウントが１減る
      expect{ click_on("削除")}.to change{ Item.count}.by(-1)     
      # 商品一覧ページに遷移していることを確認する
      expect(current_path).to eq items_path
      # 商品一覧ページに削除した商品が表示されていないことを確認する
      expect(page).to have_no_content(@item.price)
    end
  end
  context "商品が削除できないとき" do
    it "出品したユーザーでなければ削除できない" do
      # 出品者とは別のユーザーを作成
      another_user = FactoryBot.create(:user)
      # ログインする
      sign_in another_user
      # 商品詳細ページに移動する
      visit item_path(@item)
      # 削除ボタンが表示されていないことを確認する
      expect(page).to have_content( "削除")
    end
  end
end