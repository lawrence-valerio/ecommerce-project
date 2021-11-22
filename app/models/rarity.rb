class Rarity < ApplicationRecord
  has_many :cards

  validates :rarity_name, presence: true
end
