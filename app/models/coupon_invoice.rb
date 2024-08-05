class CouponInvoice < ApplicationRecord
  belongs_to :coupon
  belongs_to :invoice
end
