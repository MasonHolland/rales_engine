class RevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    object.to_s
  end
end
