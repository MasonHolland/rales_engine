class Api::V1::Merchants::RevenueByDateController < ApplicationController
  def index
    # render json: Merchant.revenue_by_date(params[:date]), serializer: TotalRevenueSerializer
    render json: {"total_revenue" => Merchant.revenue_by_date(params[:date]).to_s}
  end
end
