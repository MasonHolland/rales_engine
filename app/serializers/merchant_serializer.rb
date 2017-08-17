class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name, :total_revenue

  def total_revenue(date)
    object.revenue_by_date(date)
  end
end
