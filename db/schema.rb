# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_04_12_103423) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "league_teams", force: :cascade do |t|
    t.uuid "team_id"
    t.uuid "league_id"
    t.integer "points"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_teams_on_league_id"
    t.index ["team_id"], name: "index_league_teams_on_team_id"
  end

  create_table "leagues", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "team_1_id"
    t.uuid "team_2_id"
    t.uuid "host_team_id"
    t.uuid "requesting_team_id"
    t.uuid "league_id"
    t.string "match_type", default: "friendly"
    t.string "match_stage"
    t.string "status"
    t.integer "team_1_goals"
    t.integer "team_2_goals"
    t.datetime "match_dt"
    t.datetime "requested_at"
    t.datetime "responded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_team_id"], name: "index_matches_on_host_team_id"
    t.index ["league_id"], name: "index_matches_on_league_id"
    t.index ["requesting_team_id"], name: "index_matches_on_requesting_team_id"
    t.index ["team_1_id"], name: "index_matches_on_team_1_id"
    t.index ["team_2_id"], name: "index_matches_on_team_2_id"
  end

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "position"
    t.boolean "looking_for_team", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_players", force: :cascade do |t|
    t.uuid "team_id"
    t.uuid "player_id"
    t.integer "num_goals", default: 0
    t.string "status", default: "inactive"
    t.string "player_status", default: "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_team_players_on_player_id"
    t.index ["team_id", "player_id"], name: "index_team_players_on_team_id_and_player_id", unique: true
    t.index ["team_id"], name: "index_team_players_on_team_id"
  end

  create_table "teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.boolean "recruiting", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "league_teams", "leagues"
  add_foreign_key "league_teams", "teams"
  add_foreign_key "matches", "leagues"
  add_foreign_key "matches", "teams", column: "host_team_id"
  add_foreign_key "matches", "teams", column: "requesting_team_id"
  add_foreign_key "matches", "teams", column: "team_1_id"
  add_foreign_key "matches", "teams", column: "team_2_id"
  add_foreign_key "team_players", "players"
  add_foreign_key "team_players", "teams"
end
