class Api::V1::Transactions::TransactionsController < ApplicationController

  def show
    render json: Transaction.find(params[:id])
  end

  def index
    render json: Transaction.all
  end

end
