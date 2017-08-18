class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    render json: Merchant.customers_favorite_merchant(params[:id])
  end

end
