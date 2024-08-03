require 'rails_helper'

RSpec.describe Coupon, type: :model do
    it { should belong_to(:merchant) }
    it { should have_many(:items).through(:merchant) }
    it { should belong_to(:invoice) }
end
