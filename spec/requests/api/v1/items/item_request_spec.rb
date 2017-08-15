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
    get "/api/v1/items/find?name=tv"

    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end
  it "finds one item by created_at" do
    id = create(:item, created_at: "15 May 2017").id
    get "/api/v1/items/find?created_at=15 May 2017"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end
end
