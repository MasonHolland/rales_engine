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

end
