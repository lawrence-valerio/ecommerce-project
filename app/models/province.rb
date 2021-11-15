class Province < ApplicationRecord
  has_many :users

  validates :province_name, :hst, :gst, :pst, presence: true
  validates :hst, :gst, :pst, numericality: true
end
