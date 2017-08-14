describe "Invoice API" do
  it "sends a list of all items" do
    create_list(:items, 3)
    get "/api/v1/merchants.json"

    expect(response).to be_success

    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end
end
