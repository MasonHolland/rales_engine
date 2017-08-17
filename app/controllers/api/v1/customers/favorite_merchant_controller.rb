class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    render json: Merchant.find(params[:id].favorite_merchant
  end

end
