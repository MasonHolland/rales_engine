require 'rails_helper'

describe 'item relationships api', type: :request do
  context 'GET /api/v1/items/:id/invoice_items returns a collection of associated invoice items' do
    it 'returns invoice_tems' do
      item = create(:item)
      5.times do
        create(:invoice_item, item_id: item.id)
      end

      get "/api/v1/items/#{item.id}/invoice_items.json"
      result = JSON.parse(response.body)["data"]

      expect(response).to be_success
      expect(result.count).to eq(5)
    end
  end

  context 'GET /api/v1/items/:id/merchant returns the associated merchant' do
    it 'returns a merchant' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchant.json"
      result = JSON.parse(response.body)["data"]

      expect(response).to be_success
      expect(result["id"]).to eq(merchant.id.to_s)
    end
  end
end
