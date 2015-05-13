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

ActiveRecord::Schema.define(version: 20150513183459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: true do |t|
    t.string  "name"
    t.integer "war_id"
  end

  add_index "battles", ["war_id"], name: "index_battles_on_war_id", using: :btree

  create_table "battles_participants", id: false, force: true do |t|
    t.integer "battle_id"
    t.integer "participant_id"
  end

  add_index "battles_participants", ["battle_id", "participant_id"], name: "index_battles_participants_on_battle_id_and_participant_id", unique: true, using: :btree

  create_table "participants", force: true do |t|
    t.string "name"
  end

  create_table "wars", force: true do |t|
    t.string "name"
  end

end
