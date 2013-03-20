class CartItem

  attr_reader :book, :quantity

  def initialize(book)
    @book = book
    @quantity = 1
  end
  def increment_quantity
    @quantity += 1
  end
  def name
    @book.name
  end
  def price
    @book.price * @quantity
  end
end
