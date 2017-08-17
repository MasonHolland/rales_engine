class Api::V1::Merchants::RandomController < ApplicationController

  def show
    render json: Merchant.order("RANDOM()").limit(1).as_json(
      only: [:id, :name]
    )
  end

end
