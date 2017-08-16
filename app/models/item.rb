class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id
  belongs_to :merchant
  has_many :invoice_items

  def self.most_revenue(quantity)
    Item.select("items.*, sum(invoice_items.unit_price * quantity) AS revenue").
                joins(:invoice_items).group("items.id").
                order("revenue DESC").take(quantity)
  end
end
