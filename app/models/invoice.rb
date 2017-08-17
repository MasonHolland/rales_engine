class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id, :status

  has_many :transactions
  has_many :invoice_items
  belongs_to :customer
  belongs_to :merchant

  scope :unpaid, -> {find_by_sql Invoice.find_by_sql "SELECT * FROM invoices INNER JOIN transactions ON invoices.id=transactions.invoice_id WHERE result='failed' EXCEPT SELECT * FROM invoices INNER JOIN transactions ON invoices.id=transactions.invoice_id WHERE result='success'"}
end
