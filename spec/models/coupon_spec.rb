require 'rails_helper'

RSpec.describe Coupon, type: :model do
    describe 'relationships' do
        it { should belong_to(:merchant) }
        it { should have_many(:items).through(:merchant) }
        it { should have_many(:coupon_invoices) }
        it { should have_many(:invoices).through(:coupon_invoices) }
    end

    describe 'validations' do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:code) }
        it { should validate_presence_of(:discount) }
        it { should validate_presence_of(:discount_type) }
        it { should validate_presence_of(:merchant_id) }
        it { should validate_presence_of(:status) }
        

        it 'validates uniqueness of code' do
            merchant = Merchant.create!(name: "Test Merchant")
            coupon = merchant.coupons.create!(name: "10% Discount", code: "10OFF", discount: 10, discount_type: "percent", status: "active")    

            duplicate = merchant.coupons.new(name: "20% Discount", code: "10OFF", discount: 20, discount_type: "percent", status: "active")
            expect(duplicate).to_not be_valid
            expect(duplicate.errors.full_messages).to include("Code has already been taken")
        end
    end

    describe 'instance methods' do
        before :each do  
            @merchant1 = create(:merchant)
            @item1 = create(:item, merchant: @merchant1)
            @customer1 = create(:customer)
            @coupon1 = create(:coupon, name: "Coupon 1", code: "12345", discount: 10, discount_type: "percent", merchant: @merchant1)
        end

        it 'has a default status of inactive' do
            expect(@coupon1.status).to eq("inactive")
        end

        #US 3
        it 'can return the number of times it has been used if the status is completed' do
            invoice1 = Invoice.create!(customer_id: @customer1.id, status: 2)
            invoice2 = Invoice.create!(customer_id: @customer1.id, status: 2)
            invoice3 = Invoice.create!(customer_id: @customer1.id, status: 2)
            invoice4 = Invoice.create!(customer_id: @customer1.id, status: 2)

            coupon_invoice1 = create(:coupon_invoice, coupon: @coupon1, invoice: invoice1)
            coupon_invoice2 = create(:coupon_invoice, coupon: @coupon1, invoice: invoice2)
            coupon_invoice3 = create(:coupon_invoice, coupon: @coupon1, invoice: invoice3)
            coupon_invoice4 = create(:coupon_invoice, coupon: @coupon1, invoice: invoice4)

            expect(@coupon1.times_used).to eq(4)
        end

        #US 3
        it 'returns 0 if the coupon has not been used' do
            invoice1 = Invoice.create!(customer_id: @customer1.id, status: 1)
            coupon_invoice1 = CouponInvoice.create!(coupon_id: @coupon1.id, invoice_id: invoice1.id)

            expect(@coupon1.times_used).to eq(0)
        end
    end
end
