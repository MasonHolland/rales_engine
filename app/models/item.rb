class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_items(quantity)
    select("items.*, sum(invoice_items.quantity) AS total_sold")
    .joins(:invoice_items, invoices: [:transactions])
    .where(transactions: { result: "success" })
    .group(:id)
    .order("total_sold DESC")
    .limit(quantity)
  end
end
