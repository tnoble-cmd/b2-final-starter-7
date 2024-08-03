class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  belongs_to :invoice
end
