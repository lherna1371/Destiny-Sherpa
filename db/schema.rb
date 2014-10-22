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

ActiveRecord::Schema.define(version: 20141022174459) do

  create_table "event_comments", force: true do |t|
    t.integer  "event_id"
    t.string   "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "fireteam_leader"
    t.string   "fireteam_group_type"
    t.integer  "level"
    t.text     "comments"
    t.string   "video_url"
    t.datetime "date_time"
    t.string   "system"
    t.boolean  "open"
    t.text     "requests"
    t.text     "approvals"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "psn"
    t.string   "xbl"
    t.string   "destiny"
    t.integer  "rating"
    t.integer  "guardian_level"
    t.string   "guardian_type"
    t.text     "events_requested",       default: "--- []\n"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
