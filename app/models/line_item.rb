class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book

  def self.from_cart_item(cart_item)
    li = self.new
    li.book = cart_item.book
    li.quantity = cart_item.quantity
    li.total_price = cart_item.price
    li
  end
end
