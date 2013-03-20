class CreateOzekimessageouts < ActiveRecord::Migration
  def self.up
    create_table :ozekimessageouts do |t|
      t.references :order
      t.string :sender
      t.string :receiver #, :null => false, :options => "CONSTRAINT fk_ozekimessageout_users REFERENCES user(mpesa_no)"
      t.string :msg
      t.string :senttime
      t.string :receivedtime
      t.string :status
    end
  end

  def self.down
    drop_table :ozekimessageouts
  end
end
