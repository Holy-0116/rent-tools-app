class Order < ApplicationRecord
  belongs_to :borrower, class_name: "User", foreign_key: "borrower_id"
  belongs_to :item
  belongs_to :notification, dependent: :destroy, optional: true

  with_options presence: true do
    validates :piece, numericality:{ greater_than: 0 }
    validates :start_date, date: {after: Date.current, message: "は過去の日付は選べません"}
    validates :period, numericality:{ greater_than: 0 }      
    validates :price 

  end
end

