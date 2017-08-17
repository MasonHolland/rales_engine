class Api::V1::Merchants::RevenueByDateController < ApplicationController
  def index
    render json: {"total_revenue" => Merchant.revenue_by_date(params[:date]).to_s}
  end
end
