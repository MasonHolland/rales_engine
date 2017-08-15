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
    merchant_1 = Merchant.create(name: "Purveyor of Wears")
    merchant_2 = Merchant.create(name: "Purveyor of Goods")
    merchant_3 = Merchant.create(name: "Purveyor of Resources")
    merchant_4 = Merchant.create(name: "Purveyor of Arms")
    merchant_5 = Merchant.create(name: "Purveyor of Armor")


    get "/api/v1/merchants"

    expect(response).to be_success

    purveyors = JSON.parse(response.body)

    expect(purveyors.first["name"]).to eq("Purveyor of Wears")
    expect(purveyors.first["id"]).to eq(merchant_1.id)
    expect(purveyors.last["name"]).to eq("Purveyor of Armor")
    expect(purveyors.last["id"]).to eq(merchant_5.id)
  end

  it "sends a record when provided with a name" do
    merchant_1 = Merchant.create(name: "Purveyor of Wears")
    merchant_2 = Merchant.create(name: "Purveyor of Goods")
    merchant_3 = Merchant.create(name: "Purveyor of Resources")

    get "/api/v1/merchants/find?name=Purveyor of Wears"

    expect(response).to be_success

    purveyor = JSON.parse(response.body)

    expect(purveyor["name"]).to eq("Purveyor of Wears")
    expect(purveyor["id"]).to eq(merchant_1.id)
  end

  it "sends a record when provided with an id" do
    merchant_1 = Merchant.create(name: "Purveyor of Wears")
    merchant_2 = Merchant.create(name: "Purveyor of Goods")
    merchant_3 = Merchant.create(name: "Purveyor of Resources")

    get "/api/v1/merchants/find?id=#{merchant_2.id}"

    expect(response).to be_success

    purveyor = JSON.parse(response.body)

    expect(purveyor["name"]).to eq("Purveyor of Goods")
    expect(purveyor["id"]).to eq(merchant_2.id)
  end

  it "sends a record when provided with a created at date" do
    merchant_1 = Merchant.create(name: "Purveyor of Wears", created_at: "July 26 1999")
    merchant_2 = Merchant.create(name: "Purveyor of Goods", created_at: "June 19 2001")
    merchant_3 = Merchant.create(name: "Purveyor of Resources", created_at: "May 12 2015")

    get "/api/v1/merchants/find?created_at=june_19_2001"

    purveyor = JSON.parse(response.body)

    expect(purveyor["name"]).to eq("Purveyor of Goods")
    expect(purveyor["id"]).to eq(merchant_2.id)
  end

  it "sends a record when provided with an updated at date" do
    merchant_1 = Merchant.create(name: "Purveyor of Wears", created_at: "July 26 1999", updated_at: Time.now)
    merchant_2 = Merchant.create(name: "Purveyor of Goods", created_at: "June 19 2001", updated_at: "July 19 2017")

    get "/api/v1/merchants/find?updated_at=july_19_2017"

    purveyor = JSON.parse(response.body)

    expect(purveyor["name"]).to eq("Purveyor of Goods")
    expect(purveyor["id"]).to eq(merchant_2.id)
  end

  it "sends all applicable records when provided with a name" do
    merchant_1 = Merchant.create(name: "Purveyor of Wears")
    merchant_2 = Merchant.create(name: "Purveyor of Goods")
    merchant_3 = Merchant.create(name: "Purveyor of Resources")

    get "/api/v1/merchants/find_all?name=Purveyor of Wears"

    expect(response).to be_success

    purveyors = JSON.parse(response.body)

    expect(purveyors.first["name"]).to eq("Purveyor of Wears")
    expect(purveyors.first["id"]).to eq(merchant_1.id)
  end

  it "sends all applicable records when provided with an id" do
    merchant_1 = Merchant.create(name: "Purveyor of Wears")
    merchant_2 = Merchant.create(name: "Purveyor of Goods")
    merchant_3 = Merchant.create(name: "Purveyor of Resources")

    get "/api/v1/merchants/find_all?id=#{merchant_2.id}"

    expect(response).to be_success

    purveyors = JSON.parse(response.body)

    expect(purveyors.first["name"]).to eq("Purveyor of Goods")
    expect(purveyors.first["id"]).to eq(merchant_2.id)
  end

  it "sends all applicable records when provided with a created at date" do
    merchant_1 = Merchant.create(name: "Purveyor of Wears", created_at: "July 26 1999")
    merchant_2 = Merchant.create(name: "Purveyor of Goods", created_at: "June 19 2001")
    merchant_3 = Merchant.create(name: "Purveyor of Resources", created_at: "June 19 2001")

    get "/api/v1/merchants/find_all?created_at=june_19_2001"

    purveyors = JSON.parse(response.body)

    expect(purveyors.first["name"]).to eq("Purveyor of Goods")
    expect(purveyors.first["id"]).to eq(merchant_2.id)
    expect(purveyors.last["name"]).to eq("Purveyor of Resources")
    expect(purveyors.last["id"]).to eq(merchant_3.id)
  end

  it "sends all applicable records when provided with an updated at date" do
    merchant_1 = Merchant.create(name: "Purveyor of Wears", created_at: "July 26 1999", updated_at: "July 19 2017")
    merchant_2 = Merchant.create(name: "Purveyor of Goods", created_at: "June 19 2001", updated_at: "July 19 2017")

    get "/api/v1/merchants/find_all?updated_at=july_19_2017"

    purveyors = JSON.parse(response.body)

    expect(purveyors.first["name"]).to eq("Purveyor of Wears")
    expect(purveyors.first["id"]).to eq(merchant_1.id)
    expect(purveyors.last["name"]).to eq("Purveyor of Goods")
    expect(purveyors.last["id"]).to eq(merchant_2.id)
  end

  it "returns a random entry" do
    create_list(:merchant, 5)

    get "/api/v1/merchants/random"

    expect(response).to be_success

    purveyor = JSON.parse(response.body)

    expect(purveyor.count).to eq(1)
  end
end
