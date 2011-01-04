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

ActiveRecord::Schema.define(:version => 20101230163511) do

  create_table "config", :force => true do |t|
    t.string "key",   :limit => 40, :default => "", :null => false
    t.string "value",               :default => ""
  end

  add_index "config", ["key"], :name => "key", :unique => true

  create_table "extension_meta", :force => true do |t|
    t.string  "name"
    t.integer "schema_version", :default => 0
    t.boolean "enabled",        :default => true
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "path"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",         :default => false, :null => false
    t.integer  "parent_id"
    t.boolean  "external",       :default => false
    t.integer  "children_count", :default => 0,     :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "position"
    t.string   "location"
  end

  create_table "galleries_keywords", :id => false, :force => true do |t|
    t.integer "gallery_id"
    t.integer "keyword_id"
  end

  create_table "gallery_importings", :force => true do |t|
    t.integer  "gallery_id"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gallery_item_infos", :force => true do |t|
    t.integer  "gallery_item_id"
    t.string   "name"
    t.string   "value_string"
    t.text     "value_text"
    t.integer  "value_integer"
    t.datetime "value_datetime"
  end

  create_table "gallery_items", :force => true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.text     "description"
    t.integer  "gallery_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "extension"
    t.integer  "size"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "url"
    t.string   "credits"
  end

  create_table "gallery_items_keywords", :id => false, :force => true do |t|
    t.integer "gallery_item_id"
    t.integer "keyword_id"
  end

  create_table "gallery_keywords", :force => true do |t|
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "layouts", :force => true do |t|
    t.string   "name",          :limit => 100
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.string   "content_type",  :limit => 40
    t.integer  "lock_version",                 :default => 0
  end

  create_table "page_parts", :force => true do |t|
    t.string  "name",      :limit => 100
    t.string  "filter_id", :limit => 25
    t.text    "content"
    t.integer "page_id"
  end

  add_index "page_parts", ["page_id", "name"], :name => "parts_by_page"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "slug",            :limit => 100
    t.string   "breadcrumb",      :limit => 160
    t.string   "class_name",      :limit => 25
    t.integer  "status_id",                      :default => 1,     :null => false
    t.integer  "parent_id"
    t.integer  "layout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.boolean  "virtual",                        :default => false, :null => false
    t.integer  "lock_version",                   :default => 0
    t.string   "description"
    t.string   "keywords"
    t.integer  "base_gallery_id"
  end

  add_index "pages", ["class_name"], :name => "pages_class_name"
  add_index "pages", ["parent_id"], :name => "pages_parent_id"
  add_index "pages", ["slug", "parent_id"], :name => "pages_child_slug"
  add_index "pages", ["virtual", "status_id"], :name => "pages_published"

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "snippets", :force => true do |t|
    t.string   "name",          :limit => 100, :default => "", :null => false
    t.string   "filter_id",     :limit => 25
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.integer  "lock_version",                 :default => 0
  end

  add_index "snippets", ["name"], :name => "name", :unique => true

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