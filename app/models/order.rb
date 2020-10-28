class Order < ApplicationRecord
  belongs_to :borrower, class_name: "User", foreign_key: "borrower_id"
  belongs_to :item

  with_options presence: true do
    validates :borrower_id
    validates :item_id
    validates :piece
    validates :start_date  
    validates :period      
    validates :price 

  end
end

