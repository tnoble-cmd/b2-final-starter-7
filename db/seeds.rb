# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke

Coupon.create(name: "10% off", code: "10OFF", discount: 10, discount_type: "percentage", merchant_id: 1)
CouponInvoice.create(coupon_id: 1, invoice_id: 29)

Coupon.create(name: "50% off", code: "50OFF", discount: 50, discount_type: "percentage", merchant_id: 1)
CouponInvoice.create(coupon_id: 2, invoice_id: 137)

Coupon.create(name: "5000$ off", code: "5000:OFF", discount: 5000, discount_type: "dollar", merchant_id: 1)
CouponInvoice.create(coupon_id: 3, invoice_id: 155)