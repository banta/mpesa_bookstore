class Order < ActiveRecord::Base
  has_many :line_items
  has_one :ozekimessageout
  belongs_to :user
  
  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end

  def self.items_total
    sum = 0
    for item in line_items
      sum =+ item.total_price
    end
  end
end