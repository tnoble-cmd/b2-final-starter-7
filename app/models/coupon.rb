class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  belongs_to :invoice, optional: true

  enum status: { inactive: 0, active: 1}

  validates_presence_of :name, :code, :discount, :discount_type, :merchant_id, :status
  validates :code, uniqueness: { case_sensitive: false }
end
