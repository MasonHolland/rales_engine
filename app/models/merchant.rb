class Merchant < ApplicationRecord
  validates_presence_of :name

  def favorite_customer
    Customer.select("customers.*, count(transactions)")
            .joins(invoices: :transactions)
            .where("merchant_id = ? AND result = ?", id, "success")
            .group("id")
            .order("count DESC")
            .first

  end
end
