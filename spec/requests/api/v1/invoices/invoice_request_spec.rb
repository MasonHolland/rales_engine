describe "Invoice API" do
  xit "sends a list of all invoices" do
    create_list(:invoice, 3)
    get "/api/v1/invoice.json"

    expect(response).to be_success

    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(3)
  end
end
