class Rarity < ApplicationRecord
  has_many :cards

  validates :rarity_name, presence: true

  paginates_per 16
end
