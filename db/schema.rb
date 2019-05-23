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

ActiveRecord::Schema.define(version: 2019_05_22_234451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.text "line_1"
    t.text "line_2"
    t.text "city"
    t.integer "state"
    t.text "zip"
    t.boolean "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_addresses_on_owner_type_and_owner_id"
  end

  create_table "carpool_passengers", force: :cascade do |t|
    t.bigint "carpool_id"
    t.bigint "passenger_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carpool_id"], name: "index_carpool_passengers_on_carpool_id"
    t.index ["passenger_id"], name: "index_carpool_passengers_on_passenger_id"
  end

  create_table "carpools", force: :cascade do |t|
    t.bigint "driver_id"
    t.bigint "project_id"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_carpools_on_driver_id"
    t.index ["project_id"], name: "index_carpools_on_project_id"
    t.index ["vehicle_id"], name: "index_carpools_on_vehicle_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.date "date"
    t.bigint "organizer_id"
    t.string "description"
    t.string "image"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizer_id"], name: "index_projects_on_organizer_id"
  end

  create_table "user_blocks", force: :cascade do |t|
    t.bigint "blocking_user_id"
    t.bigint "blocked_user_id"
    t.index ["blocked_user_id"], name: "index_user_blocks_on_blocked_user_id"
    t.index ["blocking_user_id"], name: "index_user_blocks_on_blocking_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "about"
    t.string "avatar_image"
    t.string "google_token"
    t.decimal "google_id"
    t.integer "role"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.bigint "owner_id"
    t.text "make"
    t.text "model"
    t.text "color"
    t.integer "year"
    t.integer "fuel_efficiency"
    t.integer "fuel_type"
    t.integer "fuel_efficiency_unit"
    t.integer "passenger_limit"
    t.text "image"
    t.boolean "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_vehicles_on_owner_id"
  end

  add_foreign_key "carpool_passengers", "carpools"
  add_foreign_key "carpool_passengers", "users", column: "passenger_id"
  add_foreign_key "carpools", "projects"
  add_foreign_key "carpools", "users", column: "driver_id"
  add_foreign_key "projects", "users", column: "organizer_id"
  add_foreign_key "user_blocks", "users", column: "blocked_user_id"
  add_foreign_key "user_blocks", "users", column: "blocking_user_id"
  add_foreign_key "vehicles", "users", column: "owner_id"
end
