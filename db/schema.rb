# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130621165740) do

  create_table "addresses", :force => true do |t|
    t.string   "kind"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "addresses", ["order_id"], :name => "index_addresses_on_order_id"

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "customers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "work_phone"
    t.string   "home_phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "company"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "order_id"
    t.integer  "price_id"
    t.string   "name"
    t.decimal  "cost",       :precision => 9, :scale => 2
    t.integer  "ounces"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.integer  "quantity",                                 :default => 1
  end

  add_index "line_items", ["cart_id"], :name => "index_line_items_on_cart_id"
  add_index "line_items", ["order_id"], :name => "index_line_items_on_order_id"
  add_index "line_items", ["price_id"], :name => "index_line_items_on_price_id"

  create_table "options", :force => true do |t|
    t.integer  "product_id"
    t.string   "image"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "cat_info"
    t.string   "cat_heading"
  end

  add_index "options", ["product_id"], :name => "index_options_on_product_id"

  create_table "orders", :force => true do |t|
    t.decimal  "total_price",   :precision => 9, :scale => 2
    t.integer  "total_weight"
    t.decimal  "shipping_cost", :precision => 9, :scale => 2
    t.integer  "customer_id"
    t.datetime "archived_at"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "state"
    t.string   "uuid"
    t.string   "slug"
  end

  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"
  add_index "orders", ["slug"], :name => "index_orders_on_slug", :unique => true

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "content"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  create_table "prices", :force => true do |t|
    t.decimal  "amount",     :precision => 9, :scale => 2
    t.integer  "variant_id"
    t.integer  "weight_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "prices", ["variant_id"], :name => "index_prices_on_variant_id"
  add_index "prices", ["weight_id"], :name => "index_prices_on_weight_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "deleted_at"
    t.boolean  "featured"
    t.boolean  "active"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "category_id"
    t.boolean  "stocked"
    t.integer  "subcategory_id"
    t.text     "alternate_names"
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["subcategory_id"], :name => "index_products_on_subcategory_id"

  create_table "sliders", :force => true do |t|
    t.string   "name"
    t.string   "picture"
    t.boolean  "published"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subcategories", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
  end

  add_index "subcategories", ["category_id"], :name => "index_subcategories_on_category_id"
  add_index "subcategories", ["slug"], :name => "index_subcategories_on_slug", :unique => true

  create_table "variants", :force => true do |t|
    t.integer  "product_id"
    t.string   "sku"
    t.string   "name"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.datetime "deleted_at"
    t.boolean  "master"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.text     "description"
    t.string   "image"
    t.boolean  "stocked"
    t.string   "slug"
  end

  add_index "variants", ["product_id"], :name => "index_variants_on_product_id"
  add_index "variants", ["slug"], :name => "index_variants_on_slug", :unique => true

  create_table "weights", :force => true do |t|
    t.decimal  "ounces",     :precision => 9, :scale => 4
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.boolean  "in_pounds",                                :default => false
  end

end
