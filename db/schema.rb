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

ActiveRecord::Schema.define(:version => 20150428230734) do

  create_table "assigned_workshifts", :force => true do |t|
    t.integer  "workshift_id"
    t.integer  "user_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "completed",    :default => false
  end

  add_index "assigned_workshifts", ["user_id"], :name => "index_assigned_workshifts_on_user_id"
  add_index "assigned_workshifts", ["workshift_id"], :name => "index_assigned_workshifts_on_workshift_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "preferences", :force => true do |t|
    t.integer  "rank"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      :default => 0
    t.boolean  "workshift_manager",      :default => false
    t.string   "phone_number",           :default => ""
    t.string   "room_number",            :default => ""
    t.boolean  "display_phone_number",   :default => false
    t.boolean  "display_email",          :default => false
    t.integer  "weekly_hours",           :default => 0,     :null => false
    t.float    "hours_balance",          :default => 0.0,   :null => false
    t.text     "schedule"
    t.float    "required_hours",         :default => 5.0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invitations_count"], :name => "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "weekly_reports", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "workshift_assignments", :force => true do |t|
    t.string   "task"
    t.text     "description"
    t.time     "start_time"
    t.time     "end_time"
    t.date     "date"
    t.float    "hours"
    t.text     "schedule_id"
    t.datetime "sign_off_time"
    t.string   "status"
    t.integer  "workshifter_id"
    t.integer  "verifier_id"
    t.integer  "workshift_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "category_id"
  end

  create_table "workshifts", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "day"
    t.text     "description"
    t.string   "task"
    t.float    "hours"
    t.integer  "user_id"
    t.integer  "category_id"
  end

end
