describe "Invoice API" do
  xit "sends a list of all items" do
    create_list(:invoice, 3)
    get "/api/v1/invoice.json"

    expect(response).to be_success

    invoice = JSON.parse(response.body)
    expect(invoice.count).to eq(3)
  end
end
