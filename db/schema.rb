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

ActiveRecord::Schema.define(:version => 20130530151256) do

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "deleted_at"
    t.boolean  "featured"
    t.boolean  "active"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.decimal  "base_price",  :precision => 8, :scale => 2
  end

  create_table "variants", :force => true do |t|
    t.integer  "product_id"
    t.string   "sku"
    t.string   "name"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.datetime "deleted_at"
    t.boolean  "master"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "variants", ["product_id"], :name => "index_variants_on_product_id"

end