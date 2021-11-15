class Card < ApplicationRecord
  has_many :card_types
  has_many :types, through: :card_types
  belongs_to :rarity

  validates :name, :hp, :price, presence: true
  validates :price, numericality: true
end
