class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :borrower, class_name: "User", foreign_key: "borrower_id"
  has_many   :notifications, dependent: :destroy
            
  validates :text, length:{maximum: 120}, presence: true

  
end