# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110102053540) do

  create_table "order_line_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "property_id"
    t.integer  "quantity"
    t.decimal  "unit_price",  :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "total_price", :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "status",                                      :default => 0
    t.decimal  "amount",        :precision => 8, :scale => 2, :default => 0.0
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "oid",                                                          :null => false
    t.string   "address"
    t.string   "zip_code"
    t.string   "receiver_name"
    t.string   "mobile"
    t.string   "phone"
  end

  add_index "orders", ["oid"], :name => "index_orders_on_oid", :unique => true

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", :force => true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.decimal  "market_price", :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "price",        :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "mobile"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "xsvips", :force => true do |t|
    t.integer  "user_id"
    t.string   "card_number"
    t.string   "card_password"
    t.string   "receiver"
    t.string   "mobile"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
