class RenameCouponsInvoicesJoinTablesToCouponInvoices < ActiveRecord::Migration[7.1]
  def change
    rename_table :coupons_invoices_join_tables, :coupon_invoices
  end
end
