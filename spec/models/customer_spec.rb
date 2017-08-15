require 'rails_helper'

RSpec.describe Customer, type: :model do
  customer = Customer.new(first_name: "Finn", last_name: "The Human")

  it "is valid with valid attributes" do
    expect(customer).to be_valid
  end

  it "is invalid without a first name" do
    customer.first_name = nil

    expect(customer).to be_invalid
  end

  it "is invalid without a last name" do
    customer.last_name = nil

    expect(customer).to be_invalid
  end
end
