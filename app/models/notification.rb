class Notification < ApplicationRecord
  belongs_to :comment, optional: true
  belongs_to :order, optional: true
  belongs_to :item
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id'

  validates :action ,presence: true
  validates :checked, inclusion: {in: [true, false]}
  validates :comment_or_order, presence: true

  private
  
    def comment_or_order
      comment.presence or order.presence
    end
end
