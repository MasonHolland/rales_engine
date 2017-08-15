require 'rails_helper'

describe "customers API" do
  it "sends a single customer" do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_success

    patron = JSON.parse(response.body)

    expect(patron.id).to eq(customer.id)
  end

  xit "sends a list of customers" do
    customers = create_list(:customer, 5)

    get "/api/v1/customers"

    expect(response).to be_success

    patrons = JSON.parse(response.body)

    expect(patronss.count).to eq(5)
  end

  xit "sends a record when provided with an id" do
    customer_1 = create(:customer, first_name: "Paul")
    customer_2 = create(:customer, first_name: "Doug")

    get "/api/v1/customers/find", params: { id: customer_1.id }

    expect(response).to be_success

    patron = JSON.parse(response.body)

    expect(patron["id"]).to eq(customer_1.id)
    expect(patron["name"]).to eq("Paul")
  end

  xit "sends a record when provided with a first name" do
    customer = create(:customer, first_name: "Sam")

    get "/api/v1/customers/find", params: { first_name: "Sam" }

    expect(response).to be_success

    patron = JSON.parse(response.body)

    expect(patron["id"]).to eq(customer.id)
    expect(patron["first_name"]).to eq("Sam")
  end

  xit "sends a record when provided with a last name" do
    customer = create(:customer, last_name: "Volsung")

    get "/api/v1/customers/find", params: { last_name: "Volsung" }

    expect(response).to be_success

    patron = JSON.parse(response.body)

    expect(patron["id"]).to eq(customer.id)
    expect(patron["last_name"]).to eq("Volsung")
  end

  xit "sends a record when provided a created_at date" do
    customer = create(:customer, created_at: "12 June 1999")

    get "/api/v1/customers/find", params: { created_at: "12 June 1999" }

    expect(response).to be_success

    patron = JSON.parse(response.body)

    expect(patron["id"]).to eq(customer.id)
    expect(patron["first_name"]).to eq(customer.first_name)
  end

  xit "sends a record when provided an updated_at date" do
    customer = create(:customer, updated_at: "26 August 2011")

    get "/api/v1/customers/find", params: { updated_at: "26 August 2011" }

    expect(response).to be_success

    patron = JSON.parse(response.body)

    expect(patron["id"]).to eq(customer.id)
  end

  xit "sends all relevant records when provided with an id" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/find_all", params: { id: customer_1.id }

    expect(response).to be_success

    patrons = JSON.parse(response.body)

    expect(patrons.first["id"]).to eq(customer_1.id)
  end

  xit "sends all relevant records when provided with a first name" do
    customer_1 = create(:customer, first_name: "Paul", last_name: "Hogan")
    customer_2 = create(:customer, first_name: "Paul", last_name: "Phoenix")
    customers = create_list(:customer, 3)

    get "/api/v1/customers/find_all", params: { first_name: "Paul" }

    expect(response).to be_success

    patrons = JSON.parse(response.body)

    expect(patrons.count).to eq(2)
    expect(patrons.first["id"]).to eq(customer_1.id)
    expect(patrons.first["first_name"]).to eq("Paul")
    expect(patrons.first["last_name"]).to eq("Hogan")
    expect(patrons.last["id"]).to eq(customer_2.id)
    expect(patrons.last["first_name"]).to eq("Paul")
    expect(patrons.last["last_name"]).to eq("Phoenix")
  end

  xit "sends all relevant records when provided with a last name" do
    customer_1 = create(:customer, first_name: "Heihachi", last_name: "Mishima")
    customer_2 = create(:customer, first_name: "Kazuya", last_name: "Mishima")
    customer_3 = create(:customer, first_name: "Jin", last_name: "Mishima")
    create_list(:customer, 3)

    get "/api/v1/customers/find_all", params: { last_name: "Mishima" }

    expect(response).to be_success

    patrons = JSON.parse(response.body)

    expect(patrons.count).to eq(3)

    expect(patrons.first["id"]).to eq(customer_1.id)
    expect(patrons.first["first_name"]).to eq("Heihachi")
    expect(patrons.first["last_name"]).to eq("Mishima")
    expect(patrons.last["id"]).to eq(customer_3.id)
    expect(patrons.last["first_name"]).to eq("Jin")
    expect(patrons.last["last_name"]).to eq("Mishima")
  end

  xit "sends all relevant records when provided a created_at date" do
    customer_1 = create(:customer, created_at: "05 June 1999")
    customer_2 = create(:customer, created_at: "12 June 1999")
    customer_3 = create(:customer, created_at: "12 June 1999")
    customer_4 = create(:customer, created_at: "12 June 1999")

    get "/api/v1/customers/find_all", params: { created_at: "12 June 1999" }

    expect(response).to be_success

    patrons = JSON.parse(response.body)

    expect(patrons.count).to eq(3)
    expect(patrons.first["id"]).to eq(customer_2.id)
    expect(patrons.last["id"]).to eq(customer_4.id)
    end

  xit "sends all relevant records when provided an updated_at date" do
    customer_1 = create(:customer, created_at: "05 June 1999", updated_at: "06 June 1999")
    customer_2 = create(:customer, created_at: "12 June 1999", updated_at: "12 June 2015")
    customer_3 = create(:customer, created_at: "12 June 1999", updated_at: "12 June 2015")
    customer_4 = create(:customer, created_at: "12 June 1999", updated_at: "12 June 2015")

    get "/api/v1/customers/find_all", params: { updated_at: "12 June 2015" }

    expect(response).to be_success

    patrons = JSON.parse(response.body)

    expect(patrons.count).to eq(3)
    expect(patrons.first["id"]).to eq(customer_2.id)
    expect(patrons.last["id"]).to eq(customer_4.id)
  end

  xit "returns a random entry" do

    get "/api/v1/customers/random"

    expect(response).to be_success

    patron = JSON.parse(response.body)

    expect(customer.count).to eq(1)
  end
end
