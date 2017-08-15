require 'rails_helper'

describe "Item API" do
  it "sends a list of all items" do
    create_list(:item, 3)
    get "/api/v1/items"

    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end
  it "gets one item by its id" do
    id = create(:item).id
    get "/api/v1/items/#{id}"

    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end
  it "finds one item by name" do
    id = create(:item, name: "tv").id
    create(:item, name: "tv")
    get "/api/v1/items/find?name=tv"

    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end
  it "finds one item by description" do
    create(:item)
    id = create(:item, description: "the best item of all items").id
    create(:item, description: "the best item of all items")
    get "/api/v1/items/find?description=the best item of all items"

    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end
  it "finds one item by unit_price" do
    create(:item)
    id = create(:item, unit_price: 5.99).id
    create(:item, unit_price: 5.99)
    get "/api/v1/items/find?unit_price=5.99"

    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end
  it "finds one item by merchant_id" do
    create_list(:merchant, 2)
    create(:item, merchant: Merchant.second)
    id = create(:item, merchant: Merchant.second).id
    get "/api/v1/items/find?merchant_id=#{Merchant.second.id}"

    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end
  it "finds one item by created_at" do
    id = create(:item, created_at: "15 May 2017").id
    create(:item, created_at: "15 May 2017")
    get "/api/v1/items/find?created_at=15 May 2017"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end
  it "finds one item by updated_at" do
    id = create(:item, updated_at: "15 May 2017").id
    create(:item, updated_at: "15 May 2017")
    get "/api/v1/items/find?updated_at=15 May 2017"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end
  it "finds multiple items by name" do
    create_list(:item, 3, name: "tv")
    create(:item, name: "ipad")
    get "/api/v1/items/find_all?name=tv"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end
end
