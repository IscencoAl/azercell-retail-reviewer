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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141008130109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.string  "name"
    t.integer "region_id"
    t.boolean "is_deleted"
  end

  add_index "cities", ["region_id"], name: "index_cities_on_region_id", using: :btree

  create_table "dealers", force: true do |t|
    t.string  "name"
    t.string  "contact_name"
    t.string  "phone_number"
    t.string  "email"
    t.boolean "is_deleted"
    t.decimal "score",        precision: 5, scale: 2
  end

  create_table "employee_workpositions", force: true do |t|
    t.string  "name"
    t.boolean "is_deleted"
  end

  create_table "employees", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.integer  "shop_id"
    t.integer  "employee_workposition_id"
    t.boolean  "is_deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["employee_workposition_id"], name: "index_employees_on_employee_workposition_id", using: :btree
  add_index "employees", ["shop_id"], name: "index_employees_on_shop_id", using: :btree

  create_table "items", force: true do |t|
    t.string  "name"
    t.boolean "is_deleted"
  end

  create_table "regions", force: true do |t|
    t.string  "name"
    t.boolean "is_deleted"
  end

  create_table "report_elements", force: true do |t|
    t.string  "name"
    t.string  "value"
    t.integer "report_structure_element_type_id"
    t.integer "report_structure_category_id"
    t.integer "report_id"
  end

  add_index "report_elements", ["report_id"], name: "index_report_elements_on_report_id", using: :btree
  add_index "report_elements", ["report_structure_category_id"], name: "index_report_elements_on_report_structure_category_id", using: :btree
  add_index "report_elements", ["report_structure_element_type_id"], name: "index_report_elements_on_report_structure_element_type_id", using: :btree

  create_table "report_photos", force: true do |t|
    t.string  "photo"
    t.integer "report_id"
  end

  add_index "report_photos", ["report_id"], name: "index_report_photos_on_report_id", using: :btree

  create_table "report_structure_categories", force: true do |t|
    t.string  "name"
    t.boolean "is_deleted"
  end

  create_table "report_structure_element_types", force: true do |t|
    t.string "name"
  end

  create_table "report_structure_elements", force: true do |t|
    t.string  "name"
    t.integer "report_structure_element_type_id"
    t.integer "report_structure_category_id"
    t.integer "weight"
    t.string  "shop_types"
  end

  create_table "reports", force: true do |t|
    t.datetime "created_at"
    t.decimal  "latitude",   precision: 9, scale: 6
    t.decimal  "longitude",  precision: 9, scale: 6
    t.integer  "user_id"
    t.integer  "shop_id"
    t.decimal  "score",      precision: 5, scale: 2
  end

  add_index "reports", ["shop_id"], name: "index_reports_on_shop_id", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "shop_items", force: true do |t|
    t.integer "item_id"
    t.integer "shop_id"
  end

  add_index "shop_items", ["item_id"], name: "index_shop_items_on_item_id", using: :btree
  add_index "shop_items", ["shop_id"], name: "index_shop_items_on_shop_id", using: :btree

  create_table "shop_photos", force: true do |t|
    t.string  "photo"
    t.integer "shop_id"
  end

  add_index "shop_photos", ["shop_id"], name: "index_shop_photos_on_shop_id", using: :btree

  create_table "shop_types", force: true do |t|
    t.string  "name"
    t.string  "abbreviation"
    t.boolean "is_deleted"
  end

  create_table "shops", force: true do |t|
    t.integer "shop_type_id"
    t.integer "city_id"
    t.string  "address"
    t.decimal "latitude",       precision: 9, scale: 6
    t.decimal "longitude",      precision: 9, scale: 6
    t.integer "dealer_id"
    t.decimal "square_footage", precision: 8, scale: 2
    t.integer "user_id"
    t.boolean "is_deleted"
    t.decimal "score",          precision: 5, scale: 2
  end

  add_index "shops", ["city_id"], name: "index_shops_on_city_id", using: :btree
  add_index "shops", ["dealer_id"], name: "index_shops_on_dealer_id", using: :btree
  add_index "shops", ["shop_type_id"], name: "index_shops_on_shop_type_id", using: :btree
  add_index "shops", ["user_id"], name: "index_shops_on_user_id", using: :btree

  create_table "user_roles", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.integer  "user_role_id"
    t.boolean  "subscription",        default: false
    t.boolean  "is_deleted",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",               default: "",    null: false
    t.string   "encrypted_password",  default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "dealer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["user_role_id"], name: "index_users_on_user_role_id", using: :btree

end
