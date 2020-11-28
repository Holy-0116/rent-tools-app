class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :name
    validates :email
  end
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i}, on: :create

  has_many :comments, dependent: :destroy, foreign_key: "borrower_id"
  has_many :items, dependent: :destroy
  has_one  :address, dependent: :destroy
  has_many :card,  dependent: :destroy
  has_many :order, dependent: :destroy, foreign_key: "borrower_id"
  has_many :active_notifications, class_name: "Notification",foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification",foreign_key: "visited_id", dependent: :destroy

end
