class Province < ApplicationRecord
  has_many :users

  validates :province_name, :hst, :pst, :gst, presence: true
  validates :hst, :pst, :gst, numericality: true
end
