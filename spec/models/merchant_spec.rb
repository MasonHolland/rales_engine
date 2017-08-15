require 'rails_helper'

RSpec.describe Merchant, type: :model do
  merchant = create(:merchant, name: "Purveyor")

  it "is valid with valid attributes" do
    expect(merchant).to be_valid
  end

  it "is invalid without name" do
    merchant.name = nil

    expect(merchant).to be_invalid
  end
end
