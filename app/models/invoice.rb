class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id, :status

  belongs_to :customer
  belongs_to :merchant
end
