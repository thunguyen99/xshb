class AddInfoToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :oid, :string, :null => false
    add_column :orders, :address, :string
    add_column :orders, :zip_code, :string
    add_column :orders, :receiver_name, :string
    add_column :orders, :mobile, :string
    add_column :orders, :phone, :string

    add_index :orders, :oid ,:unique => true
  end

  def self.down
    remove_column :orders, :oid
    remove_column :orders, :address
    remove_column :orders, :zip_code
    remove_column :orders, :receiver_name
    remove_column :orders, :mobile
    remove_column :orders, :phone
  end
end
