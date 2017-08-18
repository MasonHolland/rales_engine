class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def total_revenue(date = nil)
    if date == nil
      self.successful_invoices
      .sum("invoice_items.quantity * invoice_items.unit_price")
    else
      day = Date.parse(date)
      self.successful_invoices
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
  def customers_with_pending_invoices
    Customer.find_by_sql "SELECT customers.* FROM customers INNER JOIN
                                        (SELECT invoices.* FROM invoices
                                        INNER JOIN transactions
                                        ON invoices.id=transactions.invoice_id
                                        WHERE result='failed'
                                        GROUP BY invoices.id
                                        EXCEPT
                                        SELECT invoices.* FROM invoices
                                        INNER JOIN transactions
                                        ON invoices.id=transactions.invoice_id
                                        WHERE result='success'
                                        GROUP BY invoices.id)
                                        AS pending_invoices
                                        ON customers.id=pending_invoices.customer_id
                                        WHERE merchant_id=#{self.id}"
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
                .where("invoices.created_at = ?", date)[0]["total_revenue"]
  end

  def successful_invoices
    self.invoices
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
  end
end
