require 'rails_helper'

describe "Invoice API" do
  it "sends a list of all invoices" do
    create_list(:invoice, 3)
    get "/api/v1/invoices.json"

    expect(response).to be_success

    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)
  end
  it "sends a single invoice by id" do
    id = create(:invoice).id
    create(:invoice)
    get "/api/v1/invoices/#{id}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)["data"]
    expect(invoice["id"]).to eq(id.to_s)
  end
  it "finds one invoice by customer_id" do
    create_list(:customer, 2)
    id = create(:invoice, customer_id: Customer.first.id).id
    create(:invoice, customer_id: Customer.first.id)
    get "/api/v1/invoices/find?customer_id=#{Customer.first.id}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"]).to eq(id.to_s)
  end
  it "finds one invoice by merchant_id" do
    create_list(:merchant, 2)
    id = create(:invoice, merchant_id: Merchant.first.id).id
    create(:invoice, merchant_id: Merchant.first.id)
    get "/api/v1/invoices/find?merchant_id=#{Merchant.first.id}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)["data"]
    expect(invoice["id"]).to eq(id.to_s)
  end
  it "finds one invoice by status" do
    id = create(:invoice, status: "shipped").id
    create(:invoice, status: "shipped")
    get "/api/v1/invoices/find?status=shipped"

    expect(response).to be_success

    invoice = JSON.parse(response.body)["data"]
    expect(invoice["id"]).to eq(id.to_s)
  end
  it "finds one invoice by created_at" do
    id = create(:invoice, created_at: "15 May 2017").id
    create(:invoice, created_at: "15 May 2017")
    get "/api/v1/invoices/find?created_at=15 May 2017"

    expect(response).to be_success

    invoice = JSON.parse(response.body)["data"]
    expect(invoice["id"]).to eq(id.to_s)
  end
  it "finds one invoice by updated_at" do
    id = create(:invoice, updated_at: "15 May 2017").id
    create(:invoice, updated_at: "15 May 2017")
    get "/api/v1/invoices/find?updated_at=15 May 2017"

    expect(response).to be_success

    invoice = JSON.parse(response.body)["data"]
    expect(invoice["id"]).to eq(id.to_s)
  end
  it "finds multiple invoices by customer_id" do
    create_list(:customer, 2)
    create_list(:invoice, 3, customer_id: Customer.first.id)
    create(:invoice, customer_id: Customer.second.id)
    get "/api/v1/invoices/find_all?customer_id=#{Customer.first.id}"

    expect(response).to be_success

    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)
    expect(invoices.sample["attributes"]["customer-id"]).to eq(Customer.first.id)
  end
  it "finds multiple invoices by merchant_id" do
    create_list(:merchant, 2)
    create_list(:invoice, 3, merchant_id: Merchant.first.id)
    create(:invoice, merchant_id: Merchant.second.id)
    get "/api/v1/invoices/find_all?merchant_id=#{Merchant.first.id}"

    expect(response).to be_success

    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)
    expect(invoices.sample["attributes"]["merchant-id"]).to eq(Merchant.first.id)
  end
  it "finds multiple invoices by status" do
    create_list(:invoice, 3, status: "shipped")
    create(:invoice, status: "cancelled")
    get "/api/v1/invoices/find_all?status=shipped"

    expect(response).to be_success

    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)
    expect(invoices.sample["attributes"]["status"]).to eq("shipped")
  end
  it "finds multiple invoices by status" do
    create_list(:invoice, 3, status: "shipped")
    create(:invoice, status: "cancelled")
    get "/api/v1/invoices/find_all?status=shipped"

    expect(response).to be_success

    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)

    expect(invoices.sample["attributes"]["status"]).to eq("shipped")
  end
  it "finds multiple invoices by created_at" do
    create_list(:invoice, 3, created_at: "15 May 2017")
    create(:invoice, created_at: "16 May 2017")
    get "/api/v1/invoices/find_all?created_at=15 May 2017"

    expect(response).to be_success

    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)
  end
  it "finds multiple invoices by updated_at" do
    create_list(:invoice, 3, updated_at: "15 May 2017")
    create(:invoice, updated_at: "16 May 2017")
    get "/api/v1/invoices/find_all?updated_at=15 May 2017"

    expect(response).to be_success

    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)
  end
  it "finds a random invoice" do
    create_list(:invoice, 3)

    get "/api/v1/invoices/random.json"

    expect(response).to be_success
    invoice = JSON.parse(response.body)["data"]
    expect(invoice.count).to eq(1)
  end
end
