# テーブル設計

## Userテーブル

| Column         | Type     | Options     |
| -------------- | -------- | ----------- |
| name           | string   | null: false |
| email          | string   | null: false |
| password       | string   | null: false |
| campany_name   | string   |             |

- has_one  :buyer_info
- has_one  :address
- has_many :orders
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
- belongs_to :order
- has_many :tags ,through :tag_items
- has_many :comments

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
| buyer_id       | integer  | references  |
| seller_id      | integer  | references  |
| item_id        | integer  | references  |
| piece          | integer  | null: false |
| period         | date     | null: false |
| price          | integer  | null: false |

- belongs_to :item
- belongs_to :user

## Commentテーブル

| Column         | Type     | Options     |
| -------------- | -------- | ----------- |
| customer_id    | string   | references  |
| item_id        | string   | references  |
| comment        | integer  | null: false |

- belongs_to :user
- belongs_to :item