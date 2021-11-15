class Rarity < ApplicationRecord
  has_many :cards, dependent: :destroy

  validates :rarity_name, presence: true
end
