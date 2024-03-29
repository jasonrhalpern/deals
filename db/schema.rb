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

ActiveRecord::Schema.define(version: 20150408181730) do

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.text     "website"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "businesses", ["category_id"], name: "index_businesses_on_category_id"
  add_index "businesses", ["user_id"], name: "index_businesses_on_user_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deals", force: true do |t|
    t.integer  "status"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "monday",      default: false
    t.boolean  "tuesday",     default: false
    t.boolean  "wednesday",   default: false
    t.boolean  "thursday",    default: false
    t.boolean  "friday",      default: false
    t.boolean  "saturday",    default: false
    t.boolean  "sunday",      default: false
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deals", ["business_id"], name: "index_deals_on_business_id"

  create_table "favorites", force: true do |t|
    t.integer "user_id"
    t.integer "location_id"
  end

  add_index "favorites", ["location_id"], name: "index_favorites_on_location_id"
  add_index "favorites", ["user_id", "location_id"], name: "index_favorites_on_user_id_and_location_id"
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "location_deals", force: true do |t|
    t.integer "deal_id"
    t.integer "location_id"
  end

  add_index "location_deals", ["deal_id"], name: "index_location_deals_on_deal_id"
  add_index "location_deals", ["location_id"], name: "index_location_deals_on_location_id"

  create_table "locations", force: true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone_number"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["business_id"], name: "index_locations_on_business_id"
  add_index "locations", ["latitude", "longitude"], name: "index_locations_on_latitude_and_longitude"

  create_table "payments", force: true do |t|
    t.string   "stripe_cus_token"
    t.string   "stripe_sub_token"
    t.datetime "active_until"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["business_id"], name: "index_payments_on_business_id"

  create_table "plans", force: true do |t|
    t.string   "stripe_plan_token"
    t.text     "description"
    t.integer  "trial_days"
    t.string   "interval"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id"
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
