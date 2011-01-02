class CreateOrderLineItems < ActiveRecord::Migration
  def self.up
    create_table :order_line_items do |t|
      t.integer :order_id
      t.integer :user_id
      t.integer :product_id
      t.integer :property_id
      t.integer :quantity
      t.decimal :unit_price, :precision => 8, :scale => 2, :default => 0
      t.decimal :total_price, :precision => 8, :scale => 2, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :order_line_items
  end
end
