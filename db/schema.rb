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

ActiveRecord::Schema.define(:version => 20090622142748) do

  create_table "items", :force => true do |t|
    t.string   "name",        :default => "", :null => false
    t.text     "information",                 :null => false
    t.integer  "price",       :default => 0,  :null => false
    t.integer  "position",    :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["position"], :name => "index_items_on_position"

  create_table "quotes", :force => true do |t|
    t.string   "title",      :default => "", :null => false
    t.string   "reference",  :default => "", :null => false
    t.string   "to",         :default => "", :null => false
    t.string   "cc",         :default => "", :null => false
    t.text     "body",                       :null => false
    t.datetime "sent_at",
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.text     "html",                       :null => false
    t.string   "from",       :default => "", :null => false
    t.string   "subject",    :default => "", :null => false
    t.text     "intro",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
