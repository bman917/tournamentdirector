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

ActiveRecord::Schema.define(version: 20130627165445) do

  create_table "average_entries", force: true do |t|
    t.integer  "average"
    t.integer  "bowler_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "average_entries", ["bowler_id"], name: "index_average_entries_on_bowler_id"
  add_index "average_entries", ["user_id"], name: "index_average_entries_on_user_id"

  create_table "bowlers", force: true do |t|
    t.string   "name"
    t.integer  "bowling_association_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender",                 limit: 1, default: "M", null: false
  end

  add_index "bowlers", ["bowling_association_id"], name: "index_bowlers_on_bowling_association_id"

  create_table "bowling_associations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.string   "tournament_type"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "bowling_association_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tournaments", ["bowling_association_id"], name: "index_tournaments_on_bowling_association_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

end
