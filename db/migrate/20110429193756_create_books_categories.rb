class CreateBooksCategories < ActiveRecord::Migration
  def self.up
    create_table :books_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :books_categories
  end
end
