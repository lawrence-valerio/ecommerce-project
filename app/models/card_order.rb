class CardOrder < ApplicationRecord
  belongs_to :order
  belongs_to :card
end
