class Order < ApplicationRecord
  belongs_to :user
  belongs_to :status
  has_many :card_orders
  has_many :cards, through: :card_orders

  validates :user, :order_total, :hst, :gst, :pst, presence: true
  validates :order_total, :hst, :gst, :pst, numericality: true
end
