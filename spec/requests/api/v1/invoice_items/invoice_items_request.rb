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
  it "finds one invoice_item by invoice_id" do
    invoice_id = create(:invoice).id
    create(:invoice_item, invoice_id: invoice_id)
    id = create(:invoice_item, invoice_id: invoice_id).id
    get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(id)
  end
  it "finds one invoice_item by quantity" do
    id = create(:invoice_item, quantity: 3).id
    create(:invoice_item, quantity: 3)
    get "/api/v1/invoice_items/find?quantity=3"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(id)
  end
  it "finds one invoice_item by unit_price" do
    id = create(:invoice_item, unit_price: 3.99).id
    create(:invoice_item, unit_price: 3.99)
    get "/api/v1/invoice_items/find?unit_price=3.99"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(id)
  end
  it "finds one invoice_item by unit_price" do
    id = create(:invoice_item, unit_price: 3.99).id
    create(:invoice_item, unit_price: 3.99)
    get "/api/v1/invoice_items/find?unit_price=3.99"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(id)
  end
  it "finds one invoice_item by created_at" do
    id = create(:invoice_item, created_at: "15 June 2017").id
    create(:invoice_item, created_at: "15 June 2017")
    get "/api/v1/invoice_items/find?created_at=15 June 2017"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(id)
  end
  it "finds one invoice_item by updated_at" do
    id = create(:invoice_item, updated_at: "15 June 2017").id
    create(:invoice_item, updated_at: "15 June 2017")
    get "/api/v1/invoice_items/find?updated_at=15 June 2017"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(id)
  end
end
