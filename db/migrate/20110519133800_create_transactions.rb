class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :order_id
      t.string :name
      t.string :pnumber
      t.decimal :amount
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
