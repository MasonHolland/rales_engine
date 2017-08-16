require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name)}
  end
  describe "instance methods" do
    it "#favorite_customer returns customer with most successful transactions" do
      merchant = create(:merchant)
      cust_1, cust_2 = create_list(:customer, 3)
      inv_1, inv_2, inv_3 = create_list(:invoice, 3, customer: cust_1, merchant: merchant)
      inv_4, inv_5 = create_list(:invoice, 2, customer: cust_2, merchant: merchant)
      create_list(:transaction, 2, result: "failed", invoice: inv_1)
      create_list(:transaction, 2, result: "failed", invoice: inv_2)
      create(:transaction, result: "success", invoice: inv_3)
      create(:transaction, result: "success", invoice: inv_4)
      create(:transaction, result: "success", invoice: inv_5)

      expect(merchant.favorite_customer).to eq(cust_2)
    end
  end
  describe "class methods" do
    it ".most_revenue returns merchants with most revenue" do
      merch_1, merch_2, merch_3 = create_list(:merchant, 3)
      inv_1, inv_2 = create_list(:invoice, 2, merchant: merch_1)
      inv_3 = create(:invoice, merchant: merch_2)
      inv_4 = create(:invoice, merchant: merch_3)
      create(:invoice_item, invoice: inv_1, quantity: 2, unit_price: 6)
      create(:invoice_item, invoice: inv_1, quantity: 2, unit_price: 6)
      create(:invoice_item, invoice: inv_2, quantity: 2, unit_price: 6)
      create(:invoice_item, invoice: inv_3, quantity: 1, unit_price: 20)
      create(:invoice_item, invoice: inv_3, quantity: 6, unit_price: 2)
      create(:invoice_item, invoice: inv_4, quantity: 2, unit_price: 12)

      expect(Merchant.most_revenue(2)).to eq([merch_1, merch_2])
    end
  end
end
