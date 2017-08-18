class Api::V1::Merchants::MerchantsController < ApplicationController

  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find_by(merchant_params)
  end

  private

  def merchant_params
    params.permit(:id)
  end
end
