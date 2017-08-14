require 'rails_helper'

describe "merchants API" do
  it "sends a single merchant" do
    item = create(:merchant)

    get "/api/v1/merchant/#{item.id}"

    expect(response).to be_success
  end

  it "sends a list of merchants" do
    create_list(:merchant, 5)

    get "/api/v1/merchants"

    expect(response).to be_success
  end
end
