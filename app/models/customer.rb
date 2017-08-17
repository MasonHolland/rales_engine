class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices
  has_many :transactions, through: :invoices

  def self.favorite_merchant
    #why is this returning an invoice id?
    invoices
    .select("merchants.name, merchants.id, count(invoices.id) AS number_of_successful_transactions")
    .joins(:transactions, :merchant)
    .where(transactions: { result: "success" })
    .group("merchants.id")
    .order("number_of_successful_transactions DESC")
    .limit(1)
    .first
  end
end
