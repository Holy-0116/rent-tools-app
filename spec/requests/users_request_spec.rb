require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET registrations#new" do
    it "新規登録ページにアクセスすると正常にレスポンスが返ってくる" do
      sign_out @user
      get new_user_registration_path
      expect(response.status).to eq 200
    end
    it "新規登録ページにアクセスすると「会員情報入力」の文字が存在する" do
      sign_out @user
      get new_user_registration_path
      expect(response.body).to include "会員情報入力"
    end
  end

  describe "GET sessions#new" do
    it "ログインページにアクセスすると正常にレスポンスが返ってくる" do
      sign_out @user
      get new_user_session_path
      expect(response.status).to eq 200
    end
    it "ログインページにアクセスすると「ログイン」の文字が存在する" do
      sign_out @user
      get new_user_session_path
      expect(response.body).to include "ログイン"
    end
  end

  describe "GET #show" do
    it "ユーザー詳細ページにアクセスすると正常にレスポンスが返ってくる" do
      get user_path(@user)
      expect(response.status).to eq 200
    end
    it "ユーザー詳細ページにアクセスするとユーザーの名前が存在する" do
      get user_path(@user)
      expect(response.body).to include "#{@user.name}"
    end
    it "ユーザー詳細ページにアクセスすると「お知らせ」の文字が存在する" do
      get user_path(@user)
      expect(response.body).to include "お知らせ"
    end
  end

  describe "GET #edit" do
    it "ユーザー情報編集ページにアクセスすると正常にレスポンスが返ってくる" do
      get edit_user_path(@user)
      expect(response.status).to eq 200
    end
    it "ユーザー情報編集ページにアクセスすると登録したユーザーの名前が存在する" do
      get edit_user_path(@user)
      expect(response.body).to include "#{@user.name}"
    end
    it "ユーザー情報編集ページにアクセスすると登録したユーザーのEメールが存在する" do
      get edit_user_path(@user)
      expect(response.body).to include "#{@user.email}"
    end
    it "ユーザー情報編集ページにアクセスすると登録したユーザーの会社名が存在する" do
      get edit_user_path(@user)
      expect(response.body).to include "#{@user.company_name}"
    end
  end
end
