class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :memo
      t.timestamps
    end

    Product.create(:name=>"超值订阅《星尚画报》周刊")

  end

  def self.down
    drop_table :products
  end
end
