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

ActiveRecord::Schema.define(version: 20160328051705) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.string   "klass"
    t.integer  "capacity"
    t.integer  "floor"
    t.integer  "recital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "areas", ["recital_id"], name: "index_areas_on_recital_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "orderitems", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "seat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orderitems", ["order_id"], name: "index_orderitems_on_order_id", using: :btree
  add_index "orderitems", ["seat_id"], name: "index_orderitems_on_seat_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.datetime "pay_time"
    t.datetime "apply_time"
    t.datetime "refund_time"
    t.integer  "price"
    t.string   "address"
    t.string   "trac_num"
    t.string   "express"
    t.string   "name"
    t.string   "phone"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  add_index "orders", ["slug"], name: "index_orders_on_slug", unique: true, using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "pictures", ["name"], name: "index_pictures_on_name", unique: true, using: :btree
  add_index "pictures", ["slug"], name: "index_pictures_on_slug", unique: true, using: :btree

  create_table "prices", force: :cascade do |t|
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "prices", ["slug"], name: "index_prices_on_slug", unique: true, using: :btree

  create_table "recitals", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "musician"
    t.integer  "capacity"
    t.string   "music_hall"
    t.string   "address"
    t.float    "lat"
    t.float    "lng"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.string   "venue_image_file_name"
    t.string   "venue_image_content_type"
    t.integer  "venue_image_file_size"
    t.datetime "venue_image_updated_at"
    t.string   "index_image_file_name"
    t.string   "index_image_content_type"
    t.integer  "index_image_file_size"
    t.datetime "index_image_updated_at"
    t.string   "slug"
  end

  add_index "recitals", ["slug"], name: "index_recitals_on_slug", unique: true, using: :btree

  create_table "seats", force: :cascade do |t|
    t.integer  "locate_x"
    t.integer  "locate_y"
    t.boolean  "sold",       default: false
    t.integer  "area_id"
    t.integer  "price_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "seats", ["area_id"], name: "index_seats_on_area_id", using: :btree
  add_index "seats", ["price_id"], name: "index_seats_on_price_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.integer  "role"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.string   "length"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "screenshot_file_name"
    t.string   "screenshot_content_type"
    t.integer  "screenshot_file_size"
    t.datetime "screenshot_updated_at"
    t.string   "slug"
  end

  add_index "videos", ["slug"], name: "index_videos_on_slug", unique: true, using: :btree

  add_foreign_key "areas", "recitals"
  add_foreign_key "orderitems", "orders"
  add_foreign_key "orderitems", "seats"
  add_foreign_key "orders", "users"
  add_foreign_key "seats", "areas"
  add_foreign_key "seats", "prices"
end
