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

ActiveRecord::Schema[7.0].define(version: 2022_04_05_204245) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_players", force: :cascade do |t|
    t.uuid "team_id"
    t.uuid "player_id"
    t.integer "num_goals"
    t.string "status", default: "inactive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_team_players_on_player_id"
    t.index ["team_id", "player_id"], name: "index_team_players_on_team_id_and_player_id", unique: true
    t.index ["team_id"], name: "index_team_players_on_team_id"
  end

  create_table "teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "team_players", "players"
  add_foreign_key "team_players", "teams"
end
