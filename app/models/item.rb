class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :delivery_date
  belongs_to_active_hash :category
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

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

  def create_notification_comment(current_user, comment_id)
    # 商品にコメントしたユーザーへの通知作成（本人と出品者を除く）
    temp_ids = Comment.select(:borrower_id).where(item_id: id).where.not("borrower_id=? or borrower_id=?", current_user.id,user_id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id[:borrower_id])
    end
    # 出品者への通知作成（重複しないように別で作成）
      save_notification_comment(current_user, comment_id, user_id) 
   
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    # コメント投稿者が出品者であった時は通知は作成しない
    if current_user.id != visited_id
      notification = current_user.active_notifications.new(
        item_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      notification.save if notification.valid?
    end
  end
end
