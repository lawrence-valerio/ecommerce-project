class Card < ApplicationRecord
  has_one_attached :image_uploaded
  has_many :card_types
  has_many :types, through: :card_types

  has_many :card_orders
  has_many :orders, through: :card_orders

  belongs_to :rarity

  validates :name, :price, :rarity, presence: true
  validates :price, numericality: true

  paginates_per 15
end
