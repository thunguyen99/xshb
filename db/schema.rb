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

ActiveRecord::Schema.define(:version => 20110114222216) do

  create_table "articles", :force => true do |t|
    t.integer  "category_id"
    t.string   "title"
    t.text     "content"
    t.boolean  "is_published", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "issue_time"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "panel_categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "rq_image",   :default => false
    t.integer  "width",      :default => 0
    t.integer  "height",     :default => 0
  end

  create_table "panel_contents", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.boolean  "is_published",               :default => false
    t.integer  "weight",                     :default => 0
    t.integer  "panel_category_id"
    t.string   "uploaded_data_file_name"
    t.integer  "uploaded_data_file_size"
    t.string   "uploaded_data_height"
    t.string   "uploaded_data_width"
    t.datetime "uploaded_data_update_at"
    t.string   "uploaded_data_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "authorizable_type"
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id", "role_id"], :name => "index_roles_users_on_user_id_and_role_id", :unique => true

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
