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

ActiveRecord::Schema.define(version: 2018_05_31_153148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flops", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "user_id"
    t.string "comment"
    t.string "flopplayer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_flops_on_game_id"
    t.index ["user_id"], name: "index_flops_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "team_id"
    t.string "opponent_name"
    t.string "date"
    t.string "score"
    t.string "top"
    t.string "flop"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_games_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tops", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "user_id"
    t.string "comment"
    t.string "topplayer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_tops_on_game_id"
    t.index ["user_id"], name: "index_tops_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "flops", "games"
  add_foreign_key "flops", "users"
  add_foreign_key "games", "teams"
  add_foreign_key "tops", "games"
  add_foreign_key "tops", "users"
end
