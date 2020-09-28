class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :delivery_date
  belongs_to_active_hash :category
  has_one_attached :image
  belongs_to :user

  with_options presence: true do
    validates :name
    validates :image
    validates :explanation
    validates :size
    validates :category_id,numericality:{ other_than: 0, message:"select!"}
    validates :status_id,numericality:{ other_than: 0, message:"select!"}
    validates :delivery_fee_id, numericality:{ other_than: 0, message:"select!"}
    validates :delivery_date_id, numericality:{ other_than: 0, message:"select!"}
    validates :price, format:{with: /\A[0-9]+\z/, message: "invalid. Price is half-width number" },
                      numericality:{ only_integer:true }
    
  end
end
