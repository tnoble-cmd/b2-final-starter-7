class Admin::InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update]
  before_action :set_coupon, only: [:show]
  def index
    @invoices = Invoice.all
  end

  def show
  end

  def edit
  end

  def update
    @invoice.update(invoice_params)
    flash.notice = 'Invoice Has Been Updated!'
    redirect_to admin_invoice_path(@invoice)
  end

  private
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:status)
  end

  def set_coupon
    @coupon = @invoice.coupons.first
  end
end