require 'rails_helper'

RSpec.describe 'Coupon New Page' do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    
  end

  #US 2
  it "shows the new coupon page" do
    visit new_merchant_coupon_path(@merchant1)

    
    expect(page).to have_field("Name")
    expect(page).to have_field("Code")
    expect(page).to have_field("Discount")
    expect(page).to have_field("Discount type")
    expect(page).to have_button("Submit")
  end

  it "creates a new coupon" do
    visit new_merchant_coupon_path(@merchant1)

    fill_in "Name", with: "10 percent"
    fill_in "Code", with: "10OFF"
    fill_in "Discount", with: 10
    select "percent", from: "Discount type"
    select "active", from: "Status"
    click_button "Submit"

    expect(current_path).to eq(merchant_coupons_path(@merchant1))
  end

  #US 2 Sad Path code is not unique
  it "shows an error message if the coupon code already exists" do
    Coupon.create(name: "10 percent", code: "10OFF", discount: 10, discount_type: "percent", merchant_id: @merchant1.id)
    visit new_merchant_coupon_path(@merchant1)

    fill_in "Name", with: "10 percent"
    fill_in "Code", with: "10OFF"
    fill_in "Discount", with: 10
    select "percent", from: "Discount type"
    select "Active", from: "Status"
    click_button "Submit"

    expect(page).to have_content("Coupon code already exists.")
  end

  #US 2 Sad Path merchant has reached the maximum number of active coupons
  it "shows an error message if the merchant has reached the maximum number of active coupons" do
    coupon1 = Coupon.create(name: "10 percent", code: "10OFF", discount: 10, discount_type: "percent", merchant_id: @merchant1.id, status: 1)
    coupon2 = Coupon.create(name: "20 percent", code: "20OFF", discount: 20, discount_type: "percent", merchant_id: @merchant1.id, status: 1)
    coupon3 = Coupon.create(name: "30 percent", code: "30OFF", discount: 30, discount_type: "percent", merchant_id: @merchant1.id, status: 1)
    coupon4 = Coupon.create(name: "40 percent", code: "40OFF", discount: 40, discount_type: "percent", merchant_id: @merchant1.id, status: 1)
    coupon5 = Coupon.create(name: "50 percent", code: "50OFF", discount: 50, discount_type: "percent", merchant_id: @merchant1.id, status: 1)

    visit new_merchant_coupon_path(@merchant1)

    fill_in "Name", with: "60 percent"
    fill_in "Code", with: "60OFF"
    fill_in "Discount", with: 60
    select "percent", from: "Discount type"
    select "active", from: "Status"
    click_button "Submit"

    expect(page).to have_content("You have reached the maximum number of coupons allowed.")
  end
end