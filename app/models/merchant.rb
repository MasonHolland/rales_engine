class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices

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

end
