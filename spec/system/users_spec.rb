require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context "ユーザー新規登録ができるとき" do
    it "正しい情報を入力すればユーザー登録ができ、商品一覧ページに遷移する" do
      # トップページに移動する
      visit root_path
      # 新規登録ボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # 入力フォームにユーザー情報を入力する
      fill_in "名前", with: @user.name
      fill_in "Eメール", with: @user.email
      fill_in "パスワード", with: @user.password
      fill_in "パスワード（確認用）", with: @user.password_confirmation
      fill_in "会社名", with: @user.company_name
      # 新規登録ボタンを押すとUserモデルのカウントが１上がることを確認する
      expect{ find('input[name="commit"]').click }.to change{ User.count }.by(1)
      # 商品一覧ページに遷移する
      expect(current_path).to eq items_path
      # ユーザーの名前が表示されていることを確認する
      expect(page).to have_content("#{@user.name}")
      # 新規登録ボタンログインボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context "ユーザー新規登録ができないとき" do
    it "誤った情報を入力すると新規登録ができずに、新規登録ページへ戻ってくる" do
      # トップページに移動する
      visit root_path
      # 新規登録ボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in "名前", with: ""
      fill_in "Eメール", with: ""
      fill_in "パスワード", with: ""
      fill_in "パスワード（確認用）", with: ""
      # 新規登録ボタンを押してもUserモデルのカウントが上がらないことを確認する
      expect{ find( 'input[name="commit"]').click }.to change{ Item.count }.by(0)
      # 新規登録ページに戻っていることを確認する
      expect(current_path).to eq "/users"
    end
  end

end
