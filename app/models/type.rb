class Type < ApplicationRecord
  has_many :card_types
  has_many :cards, through: :card_types

  validates :type_name, presence: true

  paginates_per 16
end
