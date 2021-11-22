class Order < ApplicationRecord
  belongs_to :user
  has_many :card_orders
  has_many :cards, through: :card_orders

  validates :user, :order_total, :taxes, presence: true
  validates :order_total, :taxes, numericality: true
end
