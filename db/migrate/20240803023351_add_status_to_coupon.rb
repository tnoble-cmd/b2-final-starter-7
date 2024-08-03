class AddStatusToCoupon < ActiveRecord::Migration[7.1]
  def change
    add_column :coupons, :status, :string, default: 'inactive', null: false
  end
end
