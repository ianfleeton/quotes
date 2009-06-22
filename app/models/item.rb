class Item < ActiveRecord::Base
  acts_as_list

  def price_in_pounds
    sprintf("%.2f", price.to_f / 100.0) unless price.nil?
  end

  def price_in_pounds= price_in_pounds
    self.price = price_in_pounds.to_f * 100
  end
end
