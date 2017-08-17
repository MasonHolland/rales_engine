class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    render json: Merchant.most_revenue(params[:quantity]).as_json(
      only: [:id, :name]
    )
  end
end
