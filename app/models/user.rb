class User < ApplicationRecord
  belongs_to :province

  validates :email, :password, :name, presence: true
end
