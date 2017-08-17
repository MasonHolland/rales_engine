class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.total_revenue(date = nil)
    if date == nil
      invoices
      .joins(:invoice_items, :transactions)
      .where(transactions: { result: 'success' })
      .sum("invoice_items.quantity * invoice_items.unit_price")
    else
      day = Date.parse(date)
      invoices
      .joins(:invoice_items, :transactions)
      .where(transactions: { result: 'success' })
      .where(invoices: { created_at: day.midnight..day.end_of_day })
      .sum("invoice_items.quantity * invoice_items.unit_price")
    end
end
