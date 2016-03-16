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

ActiveRecord::Schema.define(version: 20160316034302) do

  create_table "metashifts", force: :cascade do |t|
    t.string   "category"
    t.string   "description"
    t.float    "multiplier"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "policies", force: :cascade do |t|
    t.datetime "first_day"
    t.datetime "last_day"
    t.integer  "fine_amount"
    t.datetime "fine_days"
    t.integer  "market_sell_by"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "metashift_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  add_index "shifts", ["metashift_id"], name: "index_shifts_on_metashift_id"
  add_index "shifts", ["user_id"], name: "index_shifts_on_user_id"

# Could not dump table "users" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

end
