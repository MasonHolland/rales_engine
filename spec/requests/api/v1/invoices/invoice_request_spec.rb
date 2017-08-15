require 'rails_helper'

describe "Invoice API" do
  it "sends a list of all invoices" do
    create_list(:invoice, 3)
    get "/api/v1/invoices.json"

    expect(response).to be_success

    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(3)
  end

end
