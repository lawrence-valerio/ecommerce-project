class CardType < ApplicationRecord
  belongs_to :Card
  belongs_to :Type
end
