class BooksCategory < ActiveRecord::Base

  has_many :books
  has_many :free_books

  validates_presence_of :name, :description
  validates_uniqueness_of :name

  def self.categories
    find(:all, :order => "name")
  end

  def self.search_cat(search)
    search_condition = "%" + search + "%"
    find(:all, :conditions => ['name LIKE ?', search_condition])
  end
end
