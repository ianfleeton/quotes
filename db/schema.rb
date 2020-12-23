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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2009_08_17_133436) do

  create_table "categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "profile_id", default: 0, null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["profile_id"], name: "index_categories_on_profile_id"
  end

  create_table "items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "information", null: false
    t.integer "price", default: 0, null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "profile_id"
    t.integer "category_id", default: 0, null: false
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["position"], name: "index_items_on_position"
    t.index ["profile_id"], name: "index_items_on_profile_id"
  end

  create_table "profiles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "html", null: false
    t.string "from", default: "", null: false
    t.string "subject", default: "", null: false
    t.text "intro", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "vat_number", default: "", null: false
    t.string "domain", default: "", null: false
  end

  create_table "quotes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "reference", default: "", null: false
    t.string "to", default: "", null: false
    t.string "cc", default: "", null: false
    t.text "body", null: false
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "profile_id"
    t.index ["profile_id"], name: "index_quotes_on_profile_id"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "salt", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.string "forgot_password_token", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
