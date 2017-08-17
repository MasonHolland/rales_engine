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
    expect(items.sample["name"]).to eq("tv")
  end
  it "finds multiple items by description" do
    create_list(:item, 3, description: "a really great item")
    create(:item, description: "the worst item")
    get "/api/v1/items/find_all?description=a really great item"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
    expect(items.sample["description"]).to eq("a really great item")
  end
  it "finds multiple items by unit_price" do
    create_list(:item, 3, unit_price: 6.99)
    create(:item, unit_price: 7.99)
    get "/api/v1/items/find_all?unit_price=6.99"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
    expect(items.sample["unit_price"]).to eq(6.99)
  end
  it "finds multiple items by merchant_id" do
    create_list(:merchant, 2)
    create_list(:item, 3, merchant_id: Merchant.first.id)
    create(:item, merchant_id: Merchant.second.id)
    get "/api/v1/items/find_all?merchant_id=#{Merchant.first.id}"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
    expect(items.sample["merchant_id"]).to eq(Merchant.first.id)
  end
  it "finds multiple items by created_at" do
    create_list(:item, 3, created_at: "15 May 2017")
    create(:item, created_at: "16 May 2017")
    get "/api/v1/items/find_all?created_at=15 May 2017"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end
  it "finds multiple items by updated_at" do
    create_list(:item, 3, updated_at: "15 May 2017")
    create(:item, updated_at: "16 May 2017")
    get "/api/v1/items/find_all?updated_at=15 May 2017"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end
  it "finds a random item" do
    create_list(:item, 3)

    get "/api/v1/items/random.json"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item.count).to eq(1)
  end
  it "most_revenue returns items with highest revenue" do
    item_1, item_2, item_3 = create_list(:item, 3)
    create(:invoice_item, item: item_1, quantity: 2, unit_price: 5)
    create(:invoice_item, item: item_2, quantity: 3, unit_price: 4)
    create(:invoice_item, item: item_3, quantity: 1, unit_price: 11)

    get "/api/v1/items/most_revenue?quantity=2"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(item_2.id)
    expect(items.last["id"]).to eq(item_3.id)
  end
end
