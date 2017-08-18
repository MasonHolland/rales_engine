require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name)}
  end
  describe "relationships" do
    it { should have_many(:invoices)}
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

    it "#success_invoices returns a collection of invoices with success result" do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id)
      inv_item_1, inv_item_2 = create_list(:invoice_item, 2, invoice_id: invoice.id)
      transaction = create(:transaction, result: "success", invoice_id: invoice.id)

      expect(merchant.successful_invoices).to eq([invoice, invoice])
    end

    it "#total_revenue returns a float with the total revenue from a single merchant" do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id)
      inv_item_1, inv_item_2 = create_list(:invoice_item, 2, invoice_id: invoice.id)
      transaction = create(:transaction, result: "success", invoice_id: invoice.id)

      expect(merchant.total_revenue).to eq(3.0)
    end

    it "#total_revenue returns a float with the total revenue from a single merchant when supplied with a date" do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id, created_at: Date.today.to_s)
      inv_item_1, inv_item_2 = create_list(:invoice_item, 2, invoice_id: invoice.id)
      transaction = create(:transaction, result: "success", invoice_id: invoice.id)

      expect(merchant.total_revenue(Date.today.to_s)).to eq(3.0)
    end

    xit "#customers_with_pending_invoices returns list of customers" do
      merchant = create(:merchant)
      other_merchant = create(:merchant)
      cust_1, cust_2, cust_3, cust_4 = create_list(:customer, 4)
      inv_1 = create(:invoice, customer: cust_1, merchant: merchant)
      inv_2 = create(:invoice, customer: cust_1, merchant: merchant)
      inv_3 = create(:invoice, customer: cust_2, merchant: merchant)
      inv_4 = create(:invoice, customer: cust_3, merchant: merchant)
      inv_5 = create(:invoice, customer: cust_4, merchant: other_merchant)

      create(:transaction, invoice: inv_1, result: "failed")
      create(:transaction, invoice: inv_2, result: "success")
      create(:transaction, invoice: inv_3, result: "failed")
      create(:transaction, invoice: inv_4, result: "failed")
      create(:transaction, invoice: inv_4, result: "success")
      create(:transaction, invoice: inv_5, result: "failed")

      expect(merchant.customers_with_pending_invoices).to eq([cust_1, cust_2])
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
    it "revenue_by_date returns total revenue for that date" do
      inv_1, inv_2 = create_list(:invoice, 2, created_at: "15 May 2017")
      inv_3 = create(:invoice, created_at: "16 May 2017")
      create_list(:invoice_item, 4, invoice: inv_1, quantity: 5, unit_price: 5)
      create_list(:invoice_item, 4, invoice: inv_2, quantity: 5, unit_price: 5)
      create_list(:invoice_item, 4, invoice: inv_3, quantity: 5, unit_price: 5)

      expect(Merchant.revenue_by_date("15 May 2017")).to eq(200)
    end
  end
end
