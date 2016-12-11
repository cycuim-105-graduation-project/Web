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

ActiveRecord::Schema.define(version: 20161211141121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "agendas", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "event_id"
    t.integer  "indoor_level_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["event_id"], name: "index_agendas_on_event_id", using: :btree
    t.index ["indoor_level_id"], name: "index_agendas_on_indoor_level_id", using: :btree
  end

  create_table "checkins", force: :cascade do |t|
    t.uuid     "user_id"
    t.integer  "agenda_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agenda_id"], name: "index_checkins_on_agenda_id", using: :btree
    t.index ["user_id"], name: "index_checkins_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "feature_img"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "registration_start_at"
    t.datetime "registration_end_at"
    t.integer  "quantity"
    t.integer  "vacancy"
    t.integer  "place_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["place_id"], name: "index_events_on_place_id", using: :btree
  end

  create_table "indoor_levels", force: :cascade do |t|
    t.string   "name"
    t.integer  "place_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_indoor_levels_on_place_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "google_place_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "speakers", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.integer  "agenda_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["agenda_id"], name: "index_speakers_on_agenda_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "identity",               default: "",      null: false
    t.string   "nickname"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "cellphone"
    t.string   "zipcode"
    t.string   "address"
    t.string   "company"
    t.string   "company_address"
    t.string   "job_title"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "image"
    t.json     "tokens"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  add_foreign_key "agendas", "events"
  add_foreign_key "agendas", "indoor_levels"
  add_foreign_key "checkins", "agendas"
  add_foreign_key "checkins", "users"
  add_foreign_key "events", "places"
  add_foreign_key "indoor_levels", "places"
  add_foreign_key "speakers", "agendas"
end
