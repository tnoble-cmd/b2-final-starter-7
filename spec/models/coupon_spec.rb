require 'rails_helper'

RSpec.describe Coupon, type: :model do
    describe 'relationships' do
        it { should belong_to(:merchant) }
        it { should have_many(:items).through(:merchant) }
        it { should belong_to(:invoice).optional }
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
            @invoice1 = create(:invoice, customer: @customer1, status: 2)
            @coupon1 = create(:coupon, name: "Coupon 1", code: "12345", discount: 10, discount_type: "percent", merchant: @merchant1, invoice: @invoice1)
        end

        it 'has a default status of inactive' do
            expect(@coupon1.status).to eq("inactive")
        end
    end
end
