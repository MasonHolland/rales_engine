class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id, :status

  has_many :transactions
  belongs_to :customer
  belongs_to :merchant
end
