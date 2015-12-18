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

ActiveRecord::Schema.define(version: 20151218010539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string  "name"
    t.integer "state_id"
  end

  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree
  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "category"
    t.string   "subcategory"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "picture_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "posts", ["picture_id"], name: "index_posts_on_picture_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "re_agencies", force: :cascade do |t|
    t.string   "title",       default: "",    null: false
    t.string   "street",      default: "",    null: false
    t.string   "phone",       default: "",    null: false
    t.string   "email",       default: "",    null: false
    t.string   "site",        default: ""
    t.text     "description", default: ""
    t.boolean  "active",      default: false
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "picture_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "re_agencies", ["city_id"], name: "index_re_agencies_on_city_id", using: :btree
  add_index "re_agencies", ["picture_id"], name: "index_re_agencies_on_picture_id", using: :btree
  add_index "re_agencies", ["state_id"], name: "index_re_agencies_on_state_id", using: :btree
  add_index "re_agencies", ["user_id"], name: "index_re_agencies_on_user_id", using: :btree

  create_table "re_commercials", force: :cascade do |t|
    t.string   "category",                    null: false
    t.string   "street",                      null: false
    t.string   "phone",                       null: false
    t.string   "post_type",                   null: false
    t.text     "description", default: ""
    t.integer  "price",       default: 0
    t.integer  "space",       default: 0
    t.integer  "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "active",      default: false
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "picture_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "re_commercials", ["city_id"], name: "index_re_commercials_on_city_id", using: :btree
  add_index "re_commercials", ["picture_id"], name: "index_re_commercials_on_picture_id", using: :btree
  add_index "re_commercials", ["state_id"], name: "index_re_commercials_on_state_id", using: :btree
  add_index "re_commercials", ["user_id"], name: "index_re_commercials_on_user_id", using: :btree

  create_table "re_privates", force: :cascade do |t|
    t.string   "street",      null: false
    t.string   "post_type",   null: false
    t.string   "duration",    null: false
    t.string   "apt",         null: false
    t.string   "phone",       null: false
    t.text     "description", null: false
    t.integer  "price"
    t.integer  "baths"
    t.integer  "space"
    t.integer  "rooms"
    t.integer  "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "active"
    t.boolean  "fee"
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "picture_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "re_privates", ["city_id"], name: "index_re_privates_on_city_id", using: :btree
  add_index "re_privates", ["picture_id"], name: "index_re_privates_on_picture_id", using: :btree
  add_index "re_privates", ["state_id"], name: "index_re_privates_on_state_id", using: :btree
  add_index "re_privates", ["user_id"], name: "index_re_privates_on_user_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "cities", "states"
  add_foreign_key "posts", "pictures"
  add_foreign_key "posts", "users"
  add_foreign_key "re_agencies", "cities"
  add_foreign_key "re_agencies", "pictures"
  add_foreign_key "re_agencies", "states"
  add_foreign_key "re_agencies", "users"
  add_foreign_key "re_commercials", "cities"
  add_foreign_key "re_commercials", "pictures"
  add_foreign_key "re_commercials", "states"
  add_foreign_key "re_commercials", "users"
  add_foreign_key "re_privates", "cities"
  add_foreign_key "re_privates", "pictures"
  add_foreign_key "re_privates", "states"
  add_foreign_key "re_privates", "users"
end
