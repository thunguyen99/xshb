class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.integer :product_id
      t.string :name
      t.decimal :market_price, :precision => 8, :scale => 2, :default => 0
      t.decimal :price, :precision => 8, :scale => 2, :default => 0
      t.timestamps
    end

    p = Product.first
    if p
      Property.create(:name=>"年度订阅（平邮）",:product_id=>p.id,:market_price=>240.00,:price=>220.00)
      Property.create(:name=>"半年订阅（平邮）",:product_id=>p.id,:market_price=>120.00,:price=>110.00)
      Property.create(:name=>"季度订阅（平邮）",:product_id=>p.id,:market_price=>60.00,:price=>60.00)
      Property.create(:name=>"年度订阅（挂号）",:product_id=>p.id,:market_price=>243.00,:price=>223.00)
      Property.create(:name=>"半年订阅（挂号）",:product_id=>p.id,:market_price=>123.00,:price=>113.00)
      Property.create(:name=>"季度订阅（挂号）",:product_id=>p.id,:market_price=>63.00,:price=>63.00)
    end

  end

  def self.down
    drop_table :properties
  end
end
