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

ActiveRecord::Schema.define(version: 20140123050312) do

  create_table "charges", force: true do |t|
    t.float    "total"
    t.text     "desc"
    t.string   "status"
    t.string   "pay_method"
    t.string   "feedback"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "manager"
    t.string   "cell_phone"
    t.string   "telphone"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffs", force: true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "password"
    t.string   "password_digest"
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
    t.float    "credit"
    t.float    "commission"
    t.string   "role"
    t.integer  "company_id"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
