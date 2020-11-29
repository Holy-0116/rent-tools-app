class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many   :notifications, dependent: :destroy
            
  validates :text, length:{maximum: 120}, presence: true

  
end