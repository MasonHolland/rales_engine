class Api::V1::Customers::CustomersController < ApplicationController

  def show
    render json: Customer.find(params[:id])
  end

  def index
    render json: Customer.all
  end
end
