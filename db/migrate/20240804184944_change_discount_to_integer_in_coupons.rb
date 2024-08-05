class ChangeDiscountToIntegerInCoupons < ActiveRecord::Migration[7.1]
  def change
    change_column :coupons, :discount, :integer
  end
end
