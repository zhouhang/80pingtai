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

ActiveRecord::Schema.define(version: 20140323033227) do

  create_table "announcements", force: true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channelgroups", force: true do |t|
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "operator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channelgroupships", force: true do |t|
    t.integer  "channel_id"
    t.integer  "order"
    t.integer  "channelgroup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: true do |t|
    t.string   "name"
    t.string   "area"
    t.integer  "operator_id"
    t.string   "denomination"
    t.string   "business"
    t.string   "remark"
    t.integer  "status"
    t.integer  "price_id"
    t.integer  "webapi_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.integer  "level"
    t.string   "zip_code"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["level"], name: "index_cities_on_level", using: :btree
  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree
  add_index "cities", ["pinyin"], name: "index_cities_on_pinyin", using: :btree
  add_index "cities", ["pinyin_abbr"], name: "index_cities_on_pinyin_abbr", using: :btree
  add_index "cities", ["province_id"], name: "index_cities_on_province_id", using: :btree
  add_index "cities", ["zip_code"], name: "index_cities_on_zip_code", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "manager"
    t.string   "cell_phone"
    t.string   "telphone"
    t.string   "address"
    t.string   "province"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cookies", force: true do |t|
    t.string   "site"
    t.string   "cookie"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", force: true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["city_id"], name: "index_districts_on_city_id", using: :btree
  add_index "districts", ["name"], name: "index_districts_on_name", using: :btree
  add_index "districts", ["pinyin"], name: "index_districts_on_pinyin", using: :btree
  add_index "districts", ["pinyin_abbr"], name: "index_districts_on_pinyin_abbr", using: :btree

  create_table "fundslogs", force: true do |t|
    t.text     "desc"
    t.float    "money"
    t.float    "cur_money"
    t.float    "cur_commission"
    t.integer  "staff_id"
    t.integer  "user_id"
    t.integer  "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "number"
    t.string   "city"
    t.string   "isp"
    t.string   "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prices", force: true do |t|
    t.string   "name"
    t.float    "price"
    t.float    "agent_price"
    t.float    "member_price"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinces", force: true do |t|
    t.string   "name"
    t.string   "pinyin"
    t.string   "pinyin_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "provinces", ["name"], name: "index_provinces_on_name", using: :btree
  add_index "provinces", ["pinyin"], name: "index_provinces_on_pinyin", using: :btree
  add_index "provinces", ["pinyin_abbr"], name: "index_provinces_on_pinyin_abbr", using: :btree

  create_table "staffmenuships", force: true do |t|
    t.integer  "staff_id"
    t.integer  "menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffs", force: true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "phone"
    t.string   "password"
    t.string   "password_digest"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.string   "type"
    t.string   "pay_method"
    t.string   "feedback"
    t.string   "obj"
    t.float    "fee"
    t.float    "total"
    t.string   "status"
    t.string   "location"
    t.string   "number"
    t.string   "remark"
    t.integer  "user_id"
    t.integer  "price_id"
    t.integer  "channel_id"
    t.integer  "workid_id"
    t.integer  "webapi_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "password"
    t.string   "password_digest"
    t.string   "business_password"
    t.string   "business_password_digest"
    t.float    "credit",                   default: 0.0
    t.float    "commission",               default: 0.0
    t.string   "role",                     default: "user"
    t.integer  "company_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "webapis", force: true do |t|
    t.string   "name"
    t.string   "pinyin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workids", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "business_password"
    t.integer  "priority"
    t.float    "day_limit"
    t.string   "ext1"
    t.string   "ext2"
    t.string   "business"
    t.integer  "status"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
