class Api::V1::Transactions::InvoicesController < ApplicationController

  def index
    render json: Transaction.find(params[:id]).invoice
  end
end
