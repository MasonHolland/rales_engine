class Api::V1::Merchants::MerchantsController < ApplicationController

  def index
    render json: Merchant.all.as_json(
      only: [:id, :name]
    )
  end

  def show
    render json: Merchant.find_by(merchant_params).as_json(
      only: [:id, :name]
    )
  end

  private

  def merchant_params
    params.permit(:id)
  end
end
