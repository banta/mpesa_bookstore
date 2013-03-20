class CreateOzekimessageins < ActiveRecord::Migration
  def self.up
    create_table :ozekimessageins do |t|
      t.string :sender
      t.string :receiver
      t.string :msg
      t.string :senttime
      t.string :receivedtime
    end
  end

  def self.down
    drop_table :ozekimessageins
  end
end
