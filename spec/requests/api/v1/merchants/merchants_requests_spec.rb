require 'rails_helper'

describe "merchants API" do
  it "sends a single merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_success

    purveyor = JSON.parse(response.body)

    expect(purveyor["name"]).to eq("PurveyorOfWears")
    expect(purveyor["id"]).to eq(merchant.id)
  end

  it "sends a list of merchants" do
    merchant_1 = Merchant.create(name: "Purveyor Of Wears")
    merchant_2 = Merchant.create(name: "Purveyor of Goods")
    merchant_3 = Merchant.create(name: "Purveyor of Resources")
    merchant_4 = Merchant.create(name: "Purveyor of Arms")
    merchant_5 = Merchant.create(name: "Purveyor of Armor")


    get "/api/v1/merchants"

    expect(response).to be_success

    purveyors = JSON.parse(response.body)

    expect(purveyors.first["name"]).to eq("Purveyor Of Wears")
    expect(purveyors.first["id"]).to eq(merchant_1.id)
    expect(purveyors.last["name"]).to eq("Purveyor of Armor")
    expect(purveyors.last["id"]).to eq(merchant_5.id)
  end
end
