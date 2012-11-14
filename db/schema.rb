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

ActiveRecord::Schema.define(:version => 20090817133436) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "profile_id", :default => 0, :null => false
    t.integer  "position",   :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "categories", ["profile_id"], :name => "index_categories_on_profile_id"

  create_table "items", :force => true do |t|
    t.string   "name",        :default => "", :null => false
    t.text     "information",                 :null => false
    t.integer  "price",       :default => 0,  :null => false
    t.integer  "position",    :default => 0,  :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "profile_id"
    t.integer  "category_id", :default => 0,  :null => false
  end

  add_index "items", ["category_id"], :name => "index_items_on_category_id"
  add_index "items", ["position"], :name => "index_items_on_position"
  add_index "items", ["profile_id"], :name => "index_items_on_profile_id"

  create_table "profiles", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.text     "html",                       :null => false
    t.string   "from",       :default => "", :null => false
    t.string   "subject",    :default => "", :null => false
    t.text     "intro",                      :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "vat_number", :default => "", :null => false
    t.string   "domain",     :default => "", :null => false
  end

  create_table "quotes", :force => true do |t|
    t.string   "title",      :default => "", :null => false
    t.string   "reference",  :default => "", :null => false
    t.string   "to",         :default => "", :null => false
    t.string   "cc",         :default => "", :null => false
    t.text     "body",                       :null => false
    t.datetime "sent_at"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "profile_id"
  end

  add_index "quotes", ["profile_id"], :name => "index_quotes_on_profile_id"

  create_table "users", :force => true do |t|
    t.string   "email",                 :default => "",    :null => false
    t.string   "name",                  :default => "",    :null => false
    t.string   "encrypted_password",    :default => "",    :null => false
    t.string   "salt",                  :default => "",    :null => false
    t.boolean  "admin",                 :default => false, :null => false
    t.string   "forgot_password_token", :default => "",    :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

end
