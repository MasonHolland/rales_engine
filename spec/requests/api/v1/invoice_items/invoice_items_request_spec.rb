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
    id = create(:invoice_item, invoice_id: invoice_id).id
    get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(id)
  end
  it "finds one invoice_item by item_id" do
    item_id = create(:item).id
    id = create(:invoice_item, item_id: item_id).id
    get "/api/v1/invoice_items/find?item_id=#{item_id}"

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
  it "finds multiple invoice_items by item_id" do
    create_list(:item,2)
    create_list(:invoice_item, 3, item_id: Item.first.id)
    create(:invoice_item, item_id: Item.second.id)
    get "/api/v1/invoice_items/find_all?item_id=#{Item.first.id}"

    expect(response).to be_success
    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(3)
    expect(invoice_items.sample["item_id"]).to eq(Item.first.id)
  end
  it "finds multiple invoice_items by invoice_id" do
    create_list(:invoice, 2)
    create_list(:invoice_item, 3, invoice_id: Invoice.first.id)
    create(:invoice_item, invoice_id: Invoice.second.id)
    get "/api/v1/invoice_items/find_all?invoice_id=#{Invoice.first.id}"

    expect(response).to be_success
    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(3)
    expect(invoice_items.sample["invoice_id"]).to eq(Invoice.first.id)
  end
  it "finds multiple invoice_items by quantity" do
    create_list(:invoice_item, 3, quantity: 5)
    create(:invoice_item, quantity: 2)
    get "/api/v1/invoice_items/find_all?quantity=5"

    expect(response).to be_success
    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(3)
    expect(invoice_items.sample["quantity"]).to eq(5)
  end
  it "finds multiple invoice_items by unit_price" do
    create_list(:invoice_item, 3, unit_price: 5.99)
    create(:invoice_item, unit_price: 2.99)
    get "/api/v1/invoice_items/find_all?unit_price=5.99"

    expect(response).to be_success
    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(3)
    expect(invoice_items.sample["unit_price"]).to eq(5.99)
  end
  it "finds multiple invoice_items by created_at" do
    create_list(:invoice_item, 3, created_at: "15 May 2017")
    create(:invoice_item, created_at: 2.99)
    get "/api/v1/invoice_items/find_all?created_at=15 May 2017"

    expect(response).to be_success
    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(3)
  end
  it "finds multiple invoice_items by updated_at" do
    create_list(:invoice_item, 3, updated_at: "15 May 2017")
    create(:invoice_item, updated_at: 2.99)
    get "/api/v1/invoice_items/find_all?updated_at=15 May 2017"

    expect(response).to be_success
    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(3)
  end
  it "finds random invoice_item" do
    create_list(:invoice_item, 3)
    get "/api/v1/invoice_items/random"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item.count).to eq(1)
  end
end
