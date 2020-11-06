class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :delivery_date
  belongs_to_active_hash :category
  has_one_attached :image
  belongs_to :user
  has_many :comments

  with_options presence: true do
    validates :name
    validates :image
    validates :explanation
    validates :size
    validates :category_id,numericality:{ other_than: 0, message:"を選んでください"}
    validates :status_id,numericality:{ other_than: 0, message:"を選んでください"}
    validates :delivery_fee_id, numericality:{ other_than: 0, message:"を選んでください"}
    validates :delivery_date_id, numericality:{ other_than: 0, message:"を選んでください"}
    validates :stock, numericality:{ greater_than_or_equal_to: 0 }
    validates :price, format:{with: /\A[0-9]+\z/, message: "金額が表示されていません"},
                      numericality:{ only_integer: true }
    
  end

end
