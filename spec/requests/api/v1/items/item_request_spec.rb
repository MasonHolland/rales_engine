require 'rails_helper'

describe "Item API" do
  it "sends a list of all items" do
    create_list(:item, 3)
    get "/api/v1/items"

    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end
  it "sends one item by its id" do
    id = create(:item).id
    get "/api/v1/items/#{id}"

    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end
end
