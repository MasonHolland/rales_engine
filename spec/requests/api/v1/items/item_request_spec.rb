describe "Item API" do
  it "sends a list of all items" do
    create_list(:item, 3)
    get "/api/v1/item.json"

    expect(response).to be_success

    item = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end
end
