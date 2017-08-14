class Api::V1::MerchantsController < ApplicationController

  def index
    render json: Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    render json: @merchant
  end
end
