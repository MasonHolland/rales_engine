class Api::V1::InvoiceItems::InvoiceController < ApplicationController

  def show
    render json: InvoiceItem.find(params[:id]).invoice
    binding.pry
  end

end
