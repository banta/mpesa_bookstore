class FreeBook < ActiveRecord::Base

  validates_presence_of :picture,:title, :book_url, :author
  validates_uniqueness_of :title
  validates_format_of :picture,
                      :with => %r{\.(gif|jpg|png)$}i,
                      :message => 'Image must have an extension of .gif, .jpg or .png'
  validates_format_of :book_url,
                      :with => %r{\.(docx|ppt|pptx|pdf|txt|html|hml|doc)$}i,
                      :message => 'File must be a document.'

  def self.fbooks_for_download
    find(:all, :order => "title")
  end

  def self.new_fbook
    @free_book = FreeBook.new
  end
  
end