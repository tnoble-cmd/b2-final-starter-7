require 'rails_helper'

RSpec.describe 'Coupon Show Page' do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 1)

    @coupon_1 = Coupon.create!(name: "10% Off", code: "10OFF", discount: 10, discount_type: "percent", merchant_id: @merchant1.id, status: "active")

    @coupon_invoice_1 = CouponInvoice.create!(coupon_id: @coupon_1.id, invoice_id: @invoice_1.id)
    @coupon_invoice_2 = CouponInvoice.create!(coupon_id: @coupon_1.id, invoice_id: @invoice_2.id)

    visit merchant_coupon_path(@merchant1, @coupon_1)
  end

  it 'shows the coupon name, code, discount, and discount type' do
    expect(page).to have_content(@coupon_1.name)
    expect(page).to have_content(@coupon_1.code)
    expect(page).to have_content(@coupon_1.discount)
    expect(page).to have_content(@coupon_1.discount_type)
  end

  it 'shows the number of invoices the coupon has been used on, only if the status is completed == successful' do
    expect(page).to have_content("Times Used: #{@coupon_1.times_used}")
    expect(@coupon_1.times_used).to eq(1)
  end
end