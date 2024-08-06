class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :coupon_invoices
  has_many :coupons, through: :coupon_invoices

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def subtotal
    invoice_items.sum("unit_price * quantity")
  end

  def grand_total(coupon)
    if coupon.present?
      if coupon.discount_type == "percentage"
        subtotal - (subtotal * (coupon.discount.to_f / 100))
      else
        subtotal - coupon.discount
      end
    else
      subtotal
    end
  end
end
