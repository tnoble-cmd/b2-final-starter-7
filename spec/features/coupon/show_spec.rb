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

  #US 3 I see the name, code, discount, discount, type
  it 'shows the coupon name, code, discount, and discount type' do
    expect(page).to have_content(@coupon_1.name)
    expect(page).to have_content(@coupon_1.code)
    expect(page).to have_content(@coupon_1.discount)
    expect(page).to have_content(@coupon_1.discount_type)
  end

  #US 3 I see the number of invoices the coupon has been used on, if the invoice status is a "successful" transaction
  it 'shows the number of invoices the coupon has been used on, only if the status is completed == successful' do

    # There is 2 invoices that the coupon has been used on, however only 1 is deemed successful. 
    expect(page).to have_content("Times Used: #{@coupon_1.times_used}")
    expect(@coupon_1.times_used).to eq(1)
  end

  #US 4 i see a button
  it 'has a button to deactivate the coupon if it is active' do
    within "#coupon-status-button" do
      expect(page).to have_button("Deactivate")
    end
  end

  #US 4 if not active, i do not see a button
  it 'does not have a button to deactivate the coupon if it is inactive' do
    @coupon_1.update(status: 0)

    visit merchant_coupon_path(@merchant1, @coupon_1)
    
    within "#coupon-status-button" do
      expect(page).to_not have_button("Deactivate")
    end
  end

  #US 4 when i click the deactivate button, the coupon is deactivated, and im back on the show page.
  it 'deactivates the coupon when the deactivate button is clicked' do
    within "#coupon-status-button" do
      click_button "Deactivate"
    end

    expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon_1))
    expect(page).to have_content("Coupon deactivated.")
    expect(@coupon_1.reload.status).to eq("inactive")
  end
end