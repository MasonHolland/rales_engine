class Api::V1::Merchants::FindController < ApplicationController

  def show
    render json: Merchant.find_by(search_params).as_json(
      only: [:id, :name]
    )
  end

  def index
    render json: Merchant.where(search_params).as_json(
      only: [:id, :name]
    )
  end

  private

  def search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
