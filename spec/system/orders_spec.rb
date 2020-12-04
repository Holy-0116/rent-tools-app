require 'rails_helper'

RSpec.describe "決済", type: :system do
  before do
    # lender作成
    @lender = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @item.user = @lender
    # borrower作成
    @borrower = FactoryBot.create(:user)
    @address = FactoryBot.build(:address)
    @address.user = @borrower
    @address.save
    @card = FactoryBot.build(:card)
    @card.user = @borrower
    @card.save
    # 決済情報作成
    @order = FactoryBot.build(:order)
  end
  
  context "決済登録" do
    it "ユーザーの住所とクレジットカード登録ができていて、正しい入力がされれば決済ができて商品一覧ページに遷移する" do
      # ログインする
      sign_in @borrower
      # 商品詳細ページに移動する
      visit item_path(@item)
      # レンタル注文画面に進むボタンがあることを確認する
      expect(page).to have_content("レンタル注文画面に進む")
      # レンタル注文画面に進むボタンを押す
      click_on ("レンタル注文画面に進む")
      # クレジットカード登録がされていることを確認する
      expect(page).to have_content("カード番号")
      expect(page).to have_content("有効期限")
      # 次へ進むボタンがあることを確認する
      expect(find('input[class="order-next-btn"]').value).to eq "次へ進む"
      # 次へ進むボタンを押す
      click_on ("次へ進む")
      # 商品の情報が表示されていることを確認する
      expect(page).to have_content(@item.name)
      # 住所登録がされていることを確認する
      expect(page).to have_content(@borrower.address.postal_code)
      # 入力フォームに正しい情報を入力する
      fill_in "レンタルする個数", with: @item.stock
      fill_in "レンタル開始日", with: @order.start_date
      fill_in "レンタル期間", with: @order.period
      fill_in "レンタルする個数", with: @item.stock
      sleep 1
      # 料金の表示が注文数x金額xレンタル期間になっていることを確認する
      expect(find('input[id="order_price_input"]',visible: false).value).to eq "#{(@item.stock.to_i) * (@item.price.to_i) * (@order.period.to_i)}"
      # レンタルするボタンを押すと、Orderモデルのカウントが１上がる
      expect{click_on ("レンタルする")}.to change{ Order.count }.by(1)
      # 商品一覧ページに遷移することを確認する
      expect(current_path).to eq items_path
    end

    it "ユーザーの住所とクレジットカード登録ができていても、誤った入力がされれば決済できすレンタル注文画面に戻っている" do
      # ログインする
      sign_in @borrower
      # 商品詳細ページに移動する
      visit item_path(@item)
      # レンタル注文画面に進むボタンがあることを確認する
      expect(page).to have_content("レンタル注文画面に進む")
      # レンタル注文画面に進むボタンを押す
      click_on ("レンタル注文画面に進む")
      # クレジットカード登録がされていることを確認する
      expect(page).to have_content("カード番号")
      expect(page).to have_content("有効期限")
      # 次へ進むボタンがあることを確認する
      expect(find('input[class="order-next-btn"]').value).to eq "次へ進む"
      # 次へ進むボタンを押す
      click_on ("次へ進む")
      # 商品の情報が表示されていることを確認する
      expect(page).to have_content(@item.name)
      # 住所登録がされていることを確認する
      expect(page).to have_content(@borrower.address.postal_code)
      # 入力フォームに誤った情報を入力する
      fill_in "レンタルする個数", with: ""
      fill_in "レンタル開始日", with: ""
      fill_in "レンタル期間", with: ""
      fill_in "レンタルする個数", with: ""
      sleep 1
      # 料金の表示がされていないことを確認する
      expect(find('input[id="order_price_input"]',visible: false).value).to eq ""
      # レンタルするボタンを押すと、Orderモデルのカウントが１上がる
      expect{click_on ("レンタルする")}.to change{ Order.count }.by(0)
      # 商品一覧ページに遷移することを確認する
      expect(current_path).to eq "/items/#{@item.id}/order/new"
    end
  end
end
