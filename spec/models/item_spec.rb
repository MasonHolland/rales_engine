require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
  end
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:merchant_id)}
  end
  describe "class methods" do
    it ".most_revenue returns highest revenue for specified number of items" do
      item_1, item_2, item_3 = create_list(:item, 3)
      create(:invoice_item, item: item_1, quantity: 2, unit_price: 5)
      create(:invoice_item, item: item_2, quantity: 3, unit_price: 4)
      create(:invoice_item, item: item_3, quantity: 1, unit_price: 11)

      expect(Item.most_revenue(2)).to eq([item_2, item_3])
    end

    it ".most_items returns item with the most transactions" do
      item_1, item_2 = create_list(:item, 2)
      invoice = create(:invoice)
      transaction = create(:transaction, result: "success", invoice_id: invoice.id)
      inv_item_1, inv_item_2, inv_item_3 = create_list(:invoice_item, 3, item_id: item_1.id, invoice_id: invoice.id)
      inv_item_4, inv_item_5 = create_list(:invoice_item, 2, item_id: item_2.id, invoice_id: invoice.id)

      expect(Item.most_items(1)).to eq([item_1])
    end
  end

  describe "instance methods" do
    it "#best_day returns the day with the most items sold" do
      date = "June 25 1999"
      item_1, item_2 = create_list(:item, 2)
      invoice = create(:invoice, created_at: date)
      invoice_item = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
      transaction = create(:transaction, result: "success", invoice_id: invoice.id)

      expect(item_1.best_day.to_s).to eq("1999-06-25 00:00:00 UTC")
    end
  end
end
