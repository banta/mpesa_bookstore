class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :picture
      t.string :name
      t.string :author
      t.text :description
      t.string :isbn
      t.decimal :price
      t.references :books_category

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
