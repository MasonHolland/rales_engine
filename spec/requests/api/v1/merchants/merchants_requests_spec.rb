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
    merchant_1 = create(:merchant, name: "Purveyor of Wears")
    merchant_2 = create(:merchant, name: "Purveyor of Goods")
    merchant_3 = create(:merchant, name: "Purveyor of Resources")
    merchant_4 = create(:merchant, name: "Purveyor of Arms")
    merchant_5 = create(:merchant, name: "Purveyor of Armor")


    get "/api/v1/merchants"

    expect(response).to be_success

    purveyors = JSON.parse(response.body)

    expect(purveyors.first["name"]).to eq("Purveyor of Wears")
    expect(purveyors.first["id"]).to eq(merchant_1.id)
    expect(purveyors.last["name"]).to eq("Purveyor of Armor")
    expect(purveyors.last["id"]).to eq(merchant_5.id)
  end

  it "sends a record when provided with a name" do
    merchant_1 = create(:merchant, name: "Purveyor of Wears")
    merchant_2 = create(:merchant, name: "Purveyor of Goods")
    merchant_3 = create(:merchant, name: "Purveyor of Resources")

    get "/api/v1/merchants/find", params: { name: "Purveyor of Wears" }

    expect(response).to be_success

    purveyor = JSON.parse(response.body)

    expect(purveyor["name"]).to eq("Purveyor of Wears")
    expect(purveyor["id"]).to eq(merchant_1.id)
  end

  it "sends a record when provided with an id" do
    merchant_1 = create(:merchant, name: "Purveyor of Wears")
    merchant_2 = create(:merchant, name: "Purveyor of Goods")
    merchant_3 = create(:merchant, name: "Purveyor of Resources")

    get "/api/v1/merchants/find", params: { id: merchant_2.id }

    expect(response).to be_success

    purveyor = JSON.parse(response.body)

    expect(purveyor["name"]).to eq("Purveyor of Goods")
    expect(purveyor["id"]).to eq(merchant_2.id)
  end

  it "sends a record when provided with a created at date" do
    merchant_1 = create(:merchant, name: "Purveyor of Wears", created_at: "July 26 1999")
    merchant_2 = create(:merchant, name: "Purveyor of Goods", created_at: "June 19 2001")
    merchant_3 = create(:merchant, name: "Purveyor of Resources", created_at: "May 12 2015")

    get "/api/v1/merchants/find", params: { created_at: "19 June 2001" }

    purveyor = JSON.parse(response.body)

    expect(purveyor["name"]).to eq("Purveyor of Goods")
    expect(purveyor["id"]).to eq(merchant_2.id)
  end

  it "sends a record when provided with an updated at date" do
    merchant_1 = create(:merchant, name: "Purveyor of Wears", created_at: "July 26 1999", updated_at: Time.now)
    merchant_2 = create(:merchant, name: "Purveyor of Goods", created_at: "June 19 2001", updated_at: "July 19 2017")

    get "/api/v1/merchants/find", params: { updated_at: "19 July 2017" }

    purveyor = JSON.parse(response.body)

    expect(purveyor["name"]).to eq("Purveyor of Goods")
    expect(purveyor["id"]).to eq(merchant_2.id)
  end

  it "sends all applicable records when provided with a name" do
    merchant_1 = create(:merchant, name: "Purveyor of Wears")
    merchant_2 = create(:merchant, name: "Purveyor of Goods")
    merchant_3 = create(:merchant, name: "Purveyor of Resources")

    get "/api/v1/merchants/find_all", params: { name: "Purveyor of Wears" }

    expect(response).to be_success

    purveyors = JSON.parse(response.body)

    expect(purveyors.first["name"]).to eq("Purveyor of Wears")
    expect(purveyors.first["id"]).to eq(merchant_1.id)
  end

  it "sends all applicable records when provided with an id" do
    merchant_1 = create(:merchant, name: "Purveyor of Wears")
    merchant_2 = create(:merchant, name: "Purveyor of Goods")
    merchant_3 = create(:merchant, name: "Purveyor of Resources")

    get "/api/v1/merchants/find_all", params: { id: merchant_2.id }

    expect(response).to be_success

    purveyors = JSON.parse(response.body)

    expect(purveyors.first["name"]).to eq("Purveyor of Goods")
    expect(purveyors.first["id"]).to eq(merchant_2.id)
  end

  it "sends all applicable records when provided with a created at date" do
    merchant_1 = create(:merchant, name: "Purveyor of Wears", created_at: "July 26 1999")
    merchant_2 = create(:merchant, name: "Purveyor of Goods", created_at: "June 19 2001")
    merchant_3 = create(:merchant, name: "Purveyor of Resources", created_at: "June 19 2001")

    get "/api/v1/merchants/find_all", params: { created_at: "19 June 2001" }

    purveyors = JSON.parse(response.body)

    expect(purveyors.first["name"]).to eq("Purveyor of Goods")
    expect(purveyors.first["id"]).to eq(merchant_2.id)
    expect(purveyors.last["name"]).to eq("Purveyor of Resources")
    expect(purveyors.last["id"]).to eq(merchant_3.id)
  end

  it "sends all applicable records when provided with an updated at date" do
    merchant_1 = create(:merchant, name: "Purveyor of Wears", created_at: "July 26 1999", updated_at: "July 19 2017")
    merchant_2 = create(:merchant, name: "Purveyor of Goods", created_at: "June 19 2001", updated_at: "July 19 2017")

    get "/api/v1/merchants/find_all", params: { updated_at: "19 July 2017" }

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
  it "favorite customer returns customer with most successful transactions" do
    merchant = create(:merchant)
    cust_1, cust_2 = create_list(:customers, 3)
    inv_1, inv_2, inv_3 = create_list(:invoice, 3, customer: cust_1, merchant: merchant)
    inv_4, inv_5 = create_list(:invoice, 2, customer: cust_2, merchant: merchant)
    create_list(:transaction, 2, result: "failed", invoice: inv_1)
    create_list(:transaction, 2, result: "failed", invoice: inv_2)
    create(:transaction, result: "success", invoice: inv_3)
    create(:transaction, result: "success", invoice: inv_4)
    create(:transaction, result: "success", invoice: inv_5)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    expect(response).to be_success
    customer = JSON.parse(response.body)
    expect(customer.count).to eq(1)
    expect(customer.id).to eq(cust_2.id)
  end
end
