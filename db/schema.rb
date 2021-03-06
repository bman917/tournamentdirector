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

ActiveRecord::Schema.define(version: 20130920161830) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["tournament_id"], name: "index_activities_on_tournament_id"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "all_events", force: true do |t|
    t.integer  "tournament_id"
    t.integer  "bowler_id"
    t.integer  "total_pinfalls"
    t.integer  "bowler_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "all_events", ["bowler_class_id"], name: "index_all_events_on_bowler_class_id"
  add_index "all_events", ["bowler_id"], name: "index_all_events_on_bowler_id"
  add_index "all_events", ["tournament_id"], name: "index_all_events_on_tournament_id"

  create_table "all_events_squad_entries", id: false, force: true do |t|
    t.integer "all_event_id"
    t.integer "squad_entry_id"
  end

  create_table "average_entries", force: true do |t|
    t.integer  "average"
    t.integer  "bowler_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "average_type"
    t.integer  "total_pinfalls"
    t.integer  "games_played"
  end

  add_index "average_entries", ["bowler_id"], name: "index_average_entries_on_bowler_id"
  add_index "average_entries", ["user_id"], name: "index_average_entries_on_user_id"

  create_table "bowler_classes", force: true do |t|
    t.string   "name"
    t.integer  "bowlers_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender",     default: "A"
  end

  add_index "bowler_classes", ["bowlers_id"], name: "index_bowler_classes_on_bowlers_id"

  create_table "bowler_classes_tournaments", id: false, force: true do |t|
    t.integer "bowler_class_id"
    t.integer "tournament_id"
  end

  create_table "bowlers", force: true do |t|
    t.string   "name"
    t.integer  "bowling_association_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender",                 limit: 1, default: "M", null: false
    t.integer  "pbc_classification_id"
    t.string   "last_name"
    t.string   "middle_name"
  end

  add_index "bowlers", ["bowling_association_id"], name: "index_bowlers_on_bowling_association_id"
  add_index "bowlers", ["pbc_classification_id"], name: "index_bowlers_on_pbc_classification_id"

  create_table "bowlers_squad_entries", id: false, force: true do |t|
    t.integer "bowler_id"
    t.integer "squad_entry_id"
  end

  create_table "bowling_associations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_types", force: true do |t|
    t.string   "name"
    t.integer  "number_of_players"
    t.integer  "number_of_games"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender",            default: "A"
  end

  create_table "game_types_tournaments", id: false, force: true do |t|
    t.integer "game_type_id"
    t.integer "tournament_id"
  end

  create_table "games", force: true do |t|
    t.integer  "score"
    t.integer  "bowler_id"
    t.string   "notes"
    t.integer  "user_id"
    t.integer  "squad_entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hdcp"
  end

  add_index "games", ["bowler_id"], name: "index_games_on_bowler_id"
  add_index "games", ["squad_entry_id"], name: "index_games_on_squad_entry_id"
  add_index "games", ["user_id"], name: "index_games_on_user_id"

  create_table "squad_entries", force: true do |t|
    t.string   "category"
    t.integer  "squad_id"
    t.integer  "game_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_pinfalls", default: 0
    t.integer  "games_count",    default: 0
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.integer  "all_event_id"
  end

  add_index "squad_entries", ["all_event_id"], name: "index_squad_entries_on_all_event_id"
  add_index "squad_entries", ["game_type_id"], name: "index_squad_entries_on_game_type_id"
  add_index "squad_entries", ["squad_id"], name: "index_squad_entries_on_squad_id"
  add_index "squad_entries", ["tournament_id"], name: "index_squad_entries_on_tournament_id"
  add_index "squad_entries", ["user_id"], name: "index_squad_entries_on_user_id"

  create_table "squads", force: true do |t|
    t.string   "name"
    t.datetime "time"
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "squad_entries_count", default: 0
  end

  add_index "squads", ["tournament_id"], name: "index_squads_on_tournament_id"
  add_index "squads", ["user_id"], name: "index_squads_on_user_id"

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

  create_table "tournaments_users", id: false, force: true do |t|
    t.integer "tournament_id"
    t.integer "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

end
