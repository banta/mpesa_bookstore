class CreateFreeBooks < ActiveRecord::Migration
  def self.up
    create_table :free_books do |t|
      t.string :picture
      t.string :title
      t.string :book_url
      t.string :author
      t.text :description
      t.references :books_category

      t.timestamps
    end
  end

  def self.down
    drop_table :free_books
  end
end
