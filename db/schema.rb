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

ActiveRecord::Schema.define(version: 2020_04_11_232002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "music_event_artists", force: :cascade do |t|
    t.bigint "artist_id"
    t.bigint "music_event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_music_event_artists_on_artist_id"
    t.index ["music_event_id"], name: "index_music_event_artists_on_music_event_id"
  end

  create_table "music_events", force: :cascade do |t|
    t.string "local"
    t.datetime "scheduled_date_time"
    t.integer "event_type"
    t.text "genres", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genres"], name: "index_music_events_on_genres", using: :gin
  end

  add_foreign_key "music_event_artists", "artists"
  add_foreign_key "music_event_artists", "music_events"
end
