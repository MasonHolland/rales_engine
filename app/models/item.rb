class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id

  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_items(quantity)
    select("items.*, sum(invoice_items.quantity) AS total_sold")
    .joins(:invoice_items, invoices: [:transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("total_sold DESC")
    .limit(quantity)

  def self.most_revenue(quantity)
    select("items.*, sum(invoice_items.unit_price * quantity) AS revenue")
    .joins(:invoice_items)
    .group("items.id")
    .order("revenue DESC")
    .take(quantity)
  end
end
