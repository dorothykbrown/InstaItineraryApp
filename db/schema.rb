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

ActiveRecord::Schema.define(version: 2019_06_04_113034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "image_url"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.text "description"
    t.string "address"
    t.integer "rating"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "price"
    t.string "website"
    t.boolean "open_now"
    t.string "photo"
    t.index ["category_id"], name: "index_events_on_category_id"
  end

  create_table "itineraries", force: :cascade do |t|
    t.string "location"
    t.integer "search_radius"
    t.integer "available_time"
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "transit_mode"
    t.index ["user_id"], name: "index_itineraries_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "itinerary_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_results_on_event_id"
    t.index ["itinerary_id"], name: "index_results_on_itinerary_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "author"
    t.string "content"
    t.integer "rating"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.index ["event_id"], name: "index_reviews_on_event_id"
  end

  create_table "user_categories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "categories"
  add_foreign_key "itineraries", "users"
  add_foreign_key "results", "events"
  add_foreign_key "results", "itineraries"
  add_foreign_key "reviews", "events"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_categories", "users"
end
