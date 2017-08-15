require 'rails_helper'

describe "InvoiceItems API" do
  it "sends a list of all invoice_items" do
    create_list(:invoice_item, 3)
    get "/api/v1/invoice_items.json"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(3)
  end
  it "sends a single invoice_item by id" do
    id = create(:invoice_item).id
    create(:invoice_item)
    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_success

    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(id)
  end
  it "finds one invoice_item by id" do
    id = create(:invoice_item).id
    create(:invoice_item)
    get "/api/v1/invoice_items/find?id=#{id}"

    expect(response).to be_success

    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(id)
  end
end
