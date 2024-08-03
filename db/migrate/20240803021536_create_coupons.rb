class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.decimal :discount
      t.string :discount_type

      t.timestamps
    end
  end
end
