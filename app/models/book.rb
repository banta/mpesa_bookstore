class Book < ActiveRecord::Base

  def self.books_for_sale
    find(:all, :order => "name")
  end

  belongs_to :books_category
  has_many :cart_items
  has_many :carts, :through => :cart_items
  has_many :line_items

  validates_presence_of :name, :books_category_id, :author, :description, :isbn, :price
  validates_uniqueness_of :name, :isbn
  validates_numericality_of :price
  validates_format_of :picture,
    :with => %r{\.(gif|jpg|png)$}i,
    :message => 'Image must have an extension of .gif, .jpg or .png'

  validate :price_must_be_at_least_a_cent

  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['name LIKE ? OR description LIKE ?', search_condition, search_condition])
  end

  def self.show(book_id)
    @book = Book.find(book_id)
  end

  protected
  def price_must_be_at_least_a_cent
    errors.add(:price, "should be at least 0.01") if price.nil? ||
      price < 1
  end
end