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

  def self.customers_favorite_merchant(id)
    joins(:transactions, :invoices)
    .where(invoices: { customer_id: id })
    .select("merchants.name, merchants.id, count(invoices.id) AS number_of_successful_transactions")
    .merge(Transaction.successful)
    .group("merchants.id")
    .order("number_of_successful_transactions DESC")
    .first
  end

  def favorite_customer
    Customer.select("customers.*, count(transactions)")
            .joins(invoices: :transactions)
            .where("merchant_id = ? AND result = ?", id, "success")
            .group("id")
            .order("count DESC")
            .first

  end

  def self.most_revenue(quantity)
    Merchant.select("merchants.*, sum(unit_price * quantity) AS revenue")
            .joins(invoices: :invoice_items)
            .group("id")
            .order("revenue DESC")
            .take(quantity)

  end

  def self.revenue_by_date(date)
    InvoiceItem.select("sum(unit_price * quantity) AS total_revenue")
                .joins(:invoice)
                .group("invoices.created_at")
                .where("invoices.created_at = ?", date)[0].as_json(:except => :id)
    #works except revenue value needs to be formatted as string; maybe serializer will help with this
  end

  private
    def self.successful_invoices
      invoices
      .joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
    end
end
