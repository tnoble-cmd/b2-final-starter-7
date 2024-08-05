class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @coupons = @merchant.coupons
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.new(coupon_params)

    if @merchant.coupons.where(status: 'active').count >= 5
      flash[:alert] = "You have reached the maximum number of coupons allowed."
      render :new
    elsif Coupon.exists?(code: @coupon.code)
      flash[:alert] = "Coupon code already exists."
      render :new
    elsif @coupon.save
      redirect_to merchant_coupons_path(@merchant), notice: "Coupon created successfully."
    else
      flash[:alert] = @coupon.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @coupon = Coupon.find(params[:id])
    @coupon.deactivate
    redirect_to merchant_coupon_path(@coupon.merchant, @coupon), notice: "Coupon deactivated."
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :discount, :discount_type, :status)
  end
end