class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user

  with_options presence: true do
  validates :postal_code   ,format: {with:/\A\d{7}\z/, message: "はハイフンなしの半角数字(7桁)を入力してください"}
  validates :prefecture_id ,numericality: {greater_than: 0, message: "を選んでください"}
  validates :city_name
  validates :house_number
  validates :phone_number  ,format: {with:/\A\d{10,11}\z/, message: "はハイフンなしの半角数字（10~11桁）を入力してください"}
  end
end
