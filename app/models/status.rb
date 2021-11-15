class Status < ApplicationRecord
  has_many :orders

  validates :order_status, presence: true
end
