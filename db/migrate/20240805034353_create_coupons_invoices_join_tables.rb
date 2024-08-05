class CreateCouponsInvoicesJoinTables < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons_invoices_join_tables do |t|
      t.references :coupon, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
