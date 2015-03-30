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

ActiveRecord::Schema.define(version: 20150330030836) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.text     "content"
    t.boolean  "primary",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "day_id"
    t.integer  "drive_id"
    t.boolean  "double_red", default: false
    t.string   "slot_time"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "appointments", ["day_id", "slot_time"], name: "index_appointments_on_day_id_and_slot_time", using: :btree
  add_index "appointments", ["day_id"], name: "index_appointments_on_day_id", using: :btree
  add_index "appointments", ["drive_id"], name: "index_appointments_on_drive_id", using: :btree
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id", using: :btree

  create_table "days", force: :cascade do |t|
    t.integer  "drive_id"
    t.date     "date"
    t.string   "start_time"
    t.string   "stop_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "days", ["drive_id"], name: "index_days_on_drive_id", using: :btree

  create_table "drives", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.string   "contact_email"
    t.integer  "max_per_slot",   default: 8
    t.integer  "time_per_slot",  default: 15
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "filepicker_url"
  end

  create_table "users", force: :cascade do |t|
    t.string   "netid"
    t.string   "email"
    t.string   "fname"
    t.string   "lname"
    t.string   "college"
    t.string   "class_year"
    t.text     "session"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "role",       default: ""
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["netid"], name: "index_users_on_netid", using: :btree

  add_foreign_key "appointments", "days"
  add_foreign_key "appointments", "drives"
  add_foreign_key "appointments", "users"
  add_foreign_key "days", "drives"
end
