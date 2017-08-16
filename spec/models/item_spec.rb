require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should belong_to(:merchant)}
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
      create(:invoice_item, item: item_3, quantity: 1, unit_price: 10)

      expect(Item.most_revenue(2)).to eq([item_2, item_3])
    end
  end
end
