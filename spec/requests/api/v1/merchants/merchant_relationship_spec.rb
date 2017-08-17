require 'rails_helper'

describe 'merchant relationships api', type: :request do
    it 'returns a collection of the merchants items' do
      merchant = create(:merchant)
      create_list(:item, 5, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"
      result = JSON.parse(response.body)["data"]

      expect(response).to be_success
      expect(result.count).to eq(5)
    end
  end
