require 'rails_helper'

describe 'customer relationships api', type: :request do
    it 'returns a collection of the customers invoices' do
      customer = create(:customer)
      create_list(:invoice, 5, customer: customer)

      get "/api/v1/customers/#{customer.id}/invoices"
      result = JSON.parse(response.body)["data"]

      expect(response).to be_success
      expect(result.count).to eq(5)
    end
  end
