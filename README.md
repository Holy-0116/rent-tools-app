# テーブル設計

## Userテーブル

| Column         | Type     | Options     |
| -------------- | -------- | ----------- |
| name           | string   | null: false |
| email          | string   | null: false |
| password       | string   | null: false |
| campany_name   | string   |             |

- has_many  :cards
- has_one  :address
- has_many :comments
- has_many :items

## Cardテーブル

| Column         | Type     | Options     |
| -------------- | -------- | ----------- |
| user_id        | integer  | references  |
| card_token     | string   | null: false |
| customer_token | string   | null: false |

- belongs_to :user

## Addressテーブル

| Column         | Type     | Options     |
| -------------- | -------- | ----------- |
| user_id        | string   | references  |
| postal_code    | string   | null: false |
| prefecture_id  | integer  | null: false |
| city_name      | string   | null: false |
| house_number   | string   | null: false |
| building_name  | string   | null: false |
| phone_number   | integer  | null: false |

- belongs_to :user

## Itemテーブル

| Column            | Type     | Options     |
| ----------------- | -------- | ----------- |
| user              | string   | references  |
| name              | string   | null: false |
| explanation       | text     | null: false |
| category_id       | integer  | null: false |
| status_id         | integer  | null: false |
| size              | string   | null: false |
| delivery_fee_id   | string   | null: false |
| delivery_date_id  | string   | null: false |
| price             | string   | null: false |
| stock             | string   | null: false |

- belongs_to :user
- has_many   :orders
- has_many   :tags ,through :tag_items
- has_many   :comments

## Tagテーブル

| Column         | Type     | Options     |
| -------------- | -------- | ----------- |
| name           | string   | references  |

- has_many :items, through :tag_items


## Tag_itemテーブル

| Column         | Type     | Options     |
| -------------- | -------- | ----------- |
| item_id        | integer  | references  |
| tag_id         | integer  | references  |

- belongs_to :tag
- belongs_to :item


## Orderテーブル

| Column         | Type     | Options     |
| -------------- | -------- | ----------- |
| borrower_id    | integer  | references  |
| lender_id      | integer  | references  |
| item_id        | integer  | references  |
| piece          | integer  | null: false |
| start_date     | date     | null: false |
| return_date    | date     | null: false |
| period         | date     | null: false |
| price          | integer  | null: false |

- belongs_to :item
- belongs_to :borrower, class_name: "User", foreign_key: "borrower_id"
- belongs_to :lender, class_name: "User", foreign_key: "lender_id"

## Commentテーブル

| Column         | Type     | Options     |
| -------------- | -------- | ----------- |
| customer_id    | string   | references  |
| item_id        | string   | references  |
| comment        | integer  | null: false |

- belongs_to :user
- belongs_to :item

---
# アプリケーション説明

 アプリケーション名

### RENT-Tools

## アプリケーション概要

このアプリケーションは、製菓道具のエコノミーシェアリングをしたいユーザー同士のマッチングを可能にしたサービスです。
主として企業間での利用を想定してますが、企業と個人での取引もできます。

## URL

- https://rent-tools-app.herokuapp.com/

## テスト用アカウント

 USER: aaaa1111@aaaa1111.com
 PWD : aaaa1111

## 利用方法

サービスを利用するためにはサインアップをしていただきます。
次にマイページに遷移して、住所登録を行っていただきます。
レンタルを行いたい方はクレジットカードの登録が必要なので、一緒に登録をしていただきます。
出品者は商品の詳細をフォームに従って入力して出品していただき、決済が行われたら配送の手続きを行っていただきます。

レンタルご利用の方は、商品を選択していただきフォームに従ってご利用期間と商品数を入力していただきます。
決済が完了したら、商品の手配がされますのでお待ちいただきます。
尚、ご利用期間は商品の発着した日を起算日として出品者のもとに配送が完了するまでとなっています。


## 目指した課題解決

製菓に従事されている方にとって道具はとても大切なものです。
しかし、個人の洋菓子店を経営されている方たちは道具の管理について多くの問題を抱えています。
新規商品の開発を行うため道具の購入を検討しているが、経費がかかってしまうので決断できない。
仮に、購入をしても通年利用の予定がないと管理する場所が必要になってしまう。
また、道具がないことが原因でお客様の要望に応えられず販売機会の損失が発生してしまう。

一方で、道具を販売している店舗では競合他社が多いため、多くの在庫を抱えてしまっていて、
管理コストだけがかかり、とても不利益です。

この問題をレンタルという形で解決できるように、企業間をつなぐことを実現しました。

## 洗い出した要件

- 商品出品機能
- 商品詳細機能
- 商品削除機能
- 商品編集機能
- 商品検索機能
- クレジットカード登録機能
- クレジットカード詳細機能
- クレジットカード削除機能
- 住所登録機能
- 住所詳細機能
- 住所編集機能
- レンタル決済機能
- コメント機能
- メール送信機能

## 実装した機能についてのGIFと説明
- 作成中

## 実装予定の機能

- コメント機能
- メール送信機能

## データベース設計

## ローカルでの動作方法
 brew install rbenv ruby-build  
 echo 'eval "$(rbenv init -)"' >> ~/.zshrc  
 source ~/.zshrc  
 brew install readline  
 brew link readline --force  
 RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)"  
 rbenv install 2.6.5  
 rbenv global 2.6.5  
 rbenv rehash  
 brew install mysql@5.6  
 mkdir ~/Library/LaunchAgents  
 ln -sfv /usr/local/opt/mysql\@5.6/*.plist ~/Library/LaunchAgents  
 launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql\@5.6.plist  
 echo 'export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"' >> ~/.zshrc  
 source ~/.zshrc  
 gem install bundler  
 gem install rails --version='6.0.0'  
 rbenv rehash  
 brew install nodejs  
 brew install yarn  


 ruby  v2.6.5  
 rails v6.0.0  
 Mysql v0.5.3  