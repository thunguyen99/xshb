class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :status, :default=> 0
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0
      t.text :memo
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
