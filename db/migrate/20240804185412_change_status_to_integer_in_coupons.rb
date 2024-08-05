class ChangeStatusToIntegerInCoupons < ActiveRecord::Migration[7.1]
  def change
    change_column_default :coupons, :status, nil
    change_column :coupons, :status, 'integer USING CAST(status AS integer)'
    change_column_default :coupons, :status, 0
    change_column_null :coupons, :status, false
  end
end
