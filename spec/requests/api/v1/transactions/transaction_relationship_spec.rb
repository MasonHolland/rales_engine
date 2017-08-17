require 'rails_helper'

describe 'transaction relationships api', type: :request do
    it 'returns the transactions invoice' do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice: invoice)

      get "/api/v1/transactions/#{transaction.id}/invoice"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.count).to eq(1)
    end
  end
