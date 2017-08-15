class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: Merchant.joins
  end

end
