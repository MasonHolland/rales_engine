require 'rails_helper'

describe 'invoice relationships api', type: :request do
  context 'GET /api/v1/invoices/:id/transactions' do
    it 'returns a collection of associated transactions' do
      invoice = create(:invoice)
      5.times do
        create(:transaction, invoice_id: invoice.id)
      end

      get "/api/v1/invoices/#{invoice.id}/transactions"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.count).to eq(5)
    end
  end

  context 'GET /api/v1/invoices/:id/invoice_items' do
    it 'returns a collection of associated invoice items' do
      invoice = create(:invoice)
      5.times do
        create(:invoice_item, invoice_id: invoice.id)
      end

      get "/api/v1/invoices/#{invoice.id}/invoice_items"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.count).to eq(5)
    end
  end

  context 'GET /api/v1/invoices/:id/items' do
    it 'returns a collection of associated items' do
      invoice = create(:invoice)
      5.times do
        create(:invoice_item, invoice_id: invoice.id)
      end

      get "/api/v1/invoices/#{invoice.id}/items"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result.count).to eq(5)
    end
  end

  context 'GET /api/v1/invoices/:id/customer' do
    it 'returns a collection of associated customers' do
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id)

      get "/api/v1/invoices/#{invoice.id}/customer"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(customer.id)
    end
  end

  context 'GET /api/v1/invoices/:id/merchant' do
    it 'returns a collection of associated merchant' do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id)

      get "/api/v1/invoices/#{invoice.id}/merchant"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(merchant.id)
    end
  end
end
