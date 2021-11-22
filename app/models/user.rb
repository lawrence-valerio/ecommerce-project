class User < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :province, :email, :password, :name, presence: true
end
