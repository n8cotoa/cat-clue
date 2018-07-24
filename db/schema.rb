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

ActiveRecord::Schema.define(version: 2018_07_23_232615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "card_type"
    t.string "card_name"
    t.boolean "answer"
    t.string "image"
    t.integer "player_id"
  end

  create_table "players", force: :cascade do |t|
    t.boolean "turn"
    t.integer "dice_roll"
    t.string "guess"
    t.string "name"
  end

  create_table "spaces", force: :cascade do |t|
    t.string "coordinates"
    t.integer "player_id"
    t.string "space_type"
  end

end
