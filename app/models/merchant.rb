class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.total_revenue(date = nil)
    if date == nil
      successful_invoices
      .sum("invoice_items.quantity * invoice_items.unit_price")
    else
      day = Date.parse(date)
      successful_invoices
      .where(invoices: { created_at: day.midnight..day.end_of_day })
      .sum("invoice_items.quantity * invoice_items.unit_price")
    end
  end

  def self.most_items(limit)
    select("merchants.*, sum(invoice_items.quantity) AS number_of_items")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id).order("number_of_items DESC")
    .limit(limit)
  end

  def self.successful_invoices
    invoices
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
  end
end
