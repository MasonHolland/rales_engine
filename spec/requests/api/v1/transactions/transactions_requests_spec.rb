require 'rails_helper'

describe "transaction API" do
  it "sends a single transaciton" do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_success

    exchange = JSON.parse(response.body)
    expect(exchange["id"]).to eq(transaction.id)
    expect(exchange["credit_card_number"]).to eq(transaction.credit_card_number)
  end

  it "it sends a list of transactions" do
    transactions = create_list(:transaction, 5)

    get "/api/v1/transactions"

    expect(response).to be_success

    exchange = JSON.parse(response.body)
    expect(exchange.count).to eq(5)
    expect(exchange.first["id"]).to eq(transactions.first.id)
  end

  it "sends a record when provided with an id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find", params: { id: transaction.id }

    expect(response).to be_success

    exchange = JSON.parse(response.body)

    expect(exchange["id"]).to eq(transaction.id)
  end

  it "sends a record when provided with an invoice id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find", params: { invoice_id: transaction.invoice_id }

    expect(response).to be_success

    exchange = JSON.parse(response.body)

    expect(exchange["id"]).to eq(transaction.id)
  end

  it "sends a record when provided with a credit card number" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find", params: { credit_card_number: transaction.credit_card_number }

    expect(response).to be_success

    exchange = JSON.parse(response.body)

    expect(exchange["id"]).to eq(transaction.id)
    expect(exchange["credit_card_number"]).to eq(transaction.credit_card_number)
  end


  it "sends a record when provided with a result" do
    transaction = create(:transaction, result: "failure")

    get "/api/v1/transactions/find", params: { result: "failure" }

    expect(response).to be_success

    exchange = JSON.parse(response.body)

    expect(exchange["id"]).to eq(transaction.id)
    expect(exchange["result"]).to eq(transaction.result)
  end

  it "sends a record when provided with a created_at date" do
    transaction = create(:transaction, created_at: "28 February 2014")

    get "/api/v1/transactions/find", params: { created_at: transaction.created_at }

    expect(response).to be_success

    exchange = JSON.parse(response.body)

    expect(exchange["id"]).to eq(transaction.id)
  end

  it "sends a record when provided with an updated at date" do
    transaction = create(:transaction, created_at: "10 September 2002", updated_at: "12 September 2002")

    get "/api/v1/transactions/find", params: { updated_at: transaction.updated_at }

    expect(response).to be_success

    exchange = JSON.parse(response.body)

    expect(exchange["id"]).to eq(transaction.id)
  end

  it "sends all applicable results when provided with an id" do
    transaction = create(:transaction)
    transactions = create_list(:transaction, 5)

    get "/api/v1/transactions/find_all", params: { id: transaction.id }

    expect(response).to be_success

    exchanges = JSON.parse(response.body)

    expect(exchanges.count).to eq(1)
    expect(exchanges.first["id"]).to eq(transaction.id)
  end

  it "sends all applicable results when provided with an invoice id" do
    invoice = create(:invoice)
    transaction_1 = create(:transaction, invoice_id: invoice.id)
    transaction_2 = create(:transaction, invoice_id: invoice.id)
    transactions = create_list(:transaction, 5)

    get "/api/v1/transactions/find_all", params: { invoice_id: transaction_1.invoice_id }

    expect(response).to be_success

    exchanges = JSON.parse(response.body)

    expect(exchanges.count).to eq(2)
    expect(exchanges.first["id"]).to eq(transaction_1.id)
    expect(exchanges.last["id"]).to eq(transaction_2.id)
  end

  it "sends all applicable results when provided with a credit card number" do
    transactions = create_list(:transaction, 5)
    transaction_1 = create(:transaction, credit_card_number: 4580251236515201)
    transaction_2 = create(:transaction, credit_card_number: 4580251236515201)

    get "/api/v1/transactions/find_all", params: { credit_card_number: "4580251236515201" }

    expect(response).to be_success

    exchanges = JSON.parse(response.body)

    expect(exchanges.count).to eq(2)
    expect(exchanges.first["id"]).to eq(transaction_1.id)
    expect(exchanges.last["id"]).to eq(transaction_2.id)
  end

  it "sends all applicable results when provided with a result" do
    transactions = create_list(:transaction, 5)
    transaction_1 = create(:transaction, result: "failure")
    transaction_2 = create(:transaction, result: "failure")

    get "/api/v1/transactions/find_all", params: { result: "failure" }

    expect(response).to be_success

    exchanges = JSON.parse(response.body)

    expect(exchanges.count).to eq(2)
    expect(exchanges.first["id"]).to eq(transaction_1.id)
    expect(exchanges.last["id"]).to eq(transaction_2.id)
  end

  it "sends all applicable results when provided with a case sensitive result" do
    transactions = create_list(:transaction, 5)
    transaction_1 = create(:transaction, result: "failure")
    transaction_2 = create(:transaction, result: "failure")

    get "/api/v1/transactions/find_all", params: { result: "FAILURE" }

    expect(response).to be_success

    exchanges = JSON.parse(response.body)

    expect(exchanges.count).to eq(2)
    expect(exchanges.first["id"]).to eq(transaction_1.id)
    expect(exchanges.last["id"]).to eq(transaction_2.id)
  end

  it "sends all applicable results when provided with a created at date" do
    transactions = create_list(:transaction, 5)
    transaction_1 = create(:transaction, created_at: "28 February 2014")
    transaction_2 = create(:transaction, created_at: "28 February 2014")

    get "/api/v1/transactions/find_all", params: { created_at: "28 February 2014" }

    expect(response).to be_success

    exchanges = JSON.parse(response.body)

    expect(exchanges.count).to eq(2)
    expect(exchanges.first["id"]).to eq(transaction_1.id)
    expect(exchanges.last["id"]).to eq(transaction_2.id)
  end

  it "sends all applicable results when provided with an updated at date" do
    transactions = create_list(:transaction, 5)
    transaction_1 = create(:transaction, created_at: "10 September 2002", updated_at: "12 September 2002")
    transaction_2 = create(:transaction, created_at: "10 September 2002", updated_at: "12 September 2002")

    get "/api/v1/transactions/find_all", params: { updated_at: "12 September 2002" }

    expect(response).to be_success

    exchanges = JSON.parse(response.body)
    expect(exchanges.count).to eq(2)
    expect(exchanges.first["id"]).to eq(transaction_1.id)
    expect(exchanges.last["id"]).to eq(transaction_2.id)
  end

  it "returns a random record" do
    create_list(:transaction, 5)

    get "/api/v1/transactions/random"

    expect(response).to be_success

    exchange = JSON.parse(response.body)

    expect(exchange.count).to eq(1)
  end
end
