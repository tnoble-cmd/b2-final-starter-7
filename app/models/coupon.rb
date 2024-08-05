class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :coupon_invoices
  has_many :invoices, through: :coupon_invoices

  enum status: { inactive: 0, active: 1}

  validates_presence_of :name, :code, :discount, :discount_type, :merchant_id, :status
  validates :code, uniqueness: { case_sensitive: false }

  def times_used
    invoices.where(status: 'completed').count
  end

  def deactivate
    update(status: :inactive)
  end
end
