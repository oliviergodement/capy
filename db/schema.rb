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

ActiveRecord::Schema.define(version: 20140528145125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "firms", force: true do |t|
    t.text     "name"
    t.integer  "shares"
    t.text     "official_address"
    t.text     "rcs"
    t.text     "court_service"
    t.text     "bank_name"
    t.text     "bank_agency"
    t.text     "bank_agency_address"
    t.text     "bank_account"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.decimal  "nominal_value",       precision: 15, scale: 7
    t.decimal  "real_value",          precision: 15, scale: 7
    t.decimal  "valuation",           precision: 15, scale: 7
    t.decimal  "initial_capital",     precision: 15, scale: 7
  end

  add_index "firms", ["user_id"], name: "index_firms_on_user_id", using: :btree

  create_table "investments", force: true do |t|
    t.float    "amount"
    t.integer  "firm_id"
    t.integer  "shareholder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round_id"
  end

  add_index "investments", ["firm_id"], name: "index_investments_on_firm_id", using: :btree
  add_index "investments", ["round_id"], name: "index_investments_on_round_id", using: :btree
  add_index "investments", ["shareholder_id"], name: "index_investments_on_shareholder_id", using: :btree

  create_table "rounds", force: true do |t|
    t.decimal  "amount_raised"
    t.decimal  "ownership_offered"
    t.text     "name"
    t.integer  "firm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rounds", ["firm_id"], name: "index_rounds_on_firm_id", using: :btree

  create_table "shareholders", force: true do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.date     "birth_date"
    t.string   "email",             default: ""
    t.string   "address"
    t.string   "nationality"
    t.boolean  "founder",           default: false
    t.decimal  "ownership"
    t.integer  "shares"
    t.decimal  "initial_ownership", default: 0.0
    t.integer  "firm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "initial_investor",  default: false
  end

  add_index "shareholders", ["firm_id"], name: "index_shareholders_on_firm_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
