class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user

  with_options presence: true do
  validates :postal_code   ,format: {with:/\A\d{7}\z/, message: " is only number. input half-width number"}
  validates :prefecture_id ,numericality: {greater_than: 0, message: "select"}
  validates :city_name
  validates :house_number
  validates :phone_number  ,format: {with:/\A\d{10,11}\z/, message: " is only number. input half-width number"}
  end
end
