require 'rails_helper'

describe 'invoice items relationships api', type: :request do
  context 'GET /api/v1/invoice_items/:id/invoice' do
    it 'returns the associated invoice' do
      invoice = create(:invoice)
      invoice_item = create(:invoice_item, invoice_id: invoice.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(invoice.id)
    end
  end
  context 'GET /api/v1/invoice_items/:id/item' do
    it 'returns the associated item' do
      item = create(:item)
      invoice_item = create(:invoice_item, item_id: item.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"
      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(item.id)
    end
  end
end
