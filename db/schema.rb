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

ActiveRecord::Schema.define(version: 20160116190707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string  "name"
    t.integer "state_id"
  end

  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree
  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "email"
  end

  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "horoscopes", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "day_description"
    t.string   "month_description"
  end

  create_table "job_agencies", force: :cascade do |t|
    t.string   "title"
    t.string   "street"
    t.string   "phone"
    t.string   "email"
    t.string   "site"
    t.text     "description"
    t.boolean  "active"
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "user_id"
    t.float    "lat"
    t.float    "lng"
    t.integer  "zip"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "job_agencies", ["city_id"], name: "index_job_agencies_on_city_id", using: :btree
  add_index "job_agencies", ["state_id"], name: "index_job_agencies_on_state_id", using: :btree
  add_index "job_agencies", ["user_id"], name: "index_job_agencies_on_user_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.string   "phone"
    t.string   "email"
    t.string   "category"
    t.string   "post_type"
    t.text     "description"
    t.boolean  "active"
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "user_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.float    "lat"
    t.float    "lng"
    t.integer  "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["city_id"], name: "index_jobs_on_city_id", using: :btree
  add_index "jobs", ["state_id"], name: "index_jobs_on_state_id", using: :btree
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "logo"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "category"
    t.string   "subcategory"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "logo"
    t.boolean  "important"
    t.string   "link"
    t.string   "description"
    t.boolean  "from_rss"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "re_agencies", force: :cascade do |t|
    t.string   "title"
    t.string   "street"
    t.string   "phone"
    t.string   "email"
    t.string   "site"
    t.text     "description"
    t.boolean  "active"
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.float    "lat"
    t.float    "lng"
    t.integer  "zip"
  end

  add_index "re_agencies", ["city_id"], name: "index_re_agencies_on_city_id", using: :btree
  add_index "re_agencies", ["state_id"], name: "index_re_agencies_on_state_id", using: :btree
  add_index "re_agencies", ["user_id"], name: "index_re_agencies_on_user_id", using: :btree

  create_table "re_commercials", force: :cascade do |t|
    t.string   "category",    default: "",    null: false
    t.string   "street",      default: "",    null: false
    t.string   "post_type",   default: "",    null: false
    t.string   "phone",       default: "",    null: false
    t.integer  "price",                       null: false
    t.integer  "space"
    t.integer  "zip"
    t.float    "lat"
    t.float    "lng"
    t.boolean  "active",      default: false
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "description", default: ""
  end

  add_index "re_commercials", ["city_id"], name: "index_re_commercials_on_city_id", using: :btree
  add_index "re_commercials", ["state_id"], name: "index_re_commercials_on_state_id", using: :btree
  add_index "re_commercials", ["user_id"], name: "index_re_commercials_on_user_id", using: :btree

  create_table "re_privates", force: :cascade do |t|
    t.string   "street",      default: "",    null: false
    t.string   "post_type",   default: "",    null: false
    t.string   "duration",    default: "",    null: false
    t.string   "phone",       default: "",    null: false
    t.integer  "price",                       null: false
    t.integer  "baths"
    t.integer  "space"
    t.integer  "rooms",                       null: false
    t.integer  "zip"
    t.float    "lat"
    t.float    "lng"
    t.boolean  "active",      default: false
    t.boolean  "fee",         default: false
    t.text     "description", default: ""
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "re_privates", ["city_id"], name: "index_re_privates_on_city_id", using: :btree
  add_index "re_privates", ["state_id"], name: "index_re_privates_on_state_id", using: :btree
  add_index "re_privates", ["user_id"], name: "index_re_privates_on_user_id", using: :btree

  create_table "sales", force: :cascade do |t|
    t.string   "title"
    t.string   "category"
    t.string   "phone"
    t.string   "email"
    t.text     "description"
    t.boolean  "active"
    t.float    "lat"
    t.float    "lng"
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "zip"
  end

  add_index "sales", ["city_id"], name: "index_sales_on_city_id", using: :btree
  add_index "sales", ["state_id"], name: "index_sales_on_state_id", using: :btree
  add_index "sales", ["user_id"], name: "index_sales_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "title"
    t.string   "street"
    t.string   "phone"
    t.string   "email"
    t.string   "site"
    t.string   "category"
    t.string   "subcategory"
    t.text     "description"
    t.boolean  "active"
    t.integer  "user_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.float    "lat"
    t.float    "lng"
    t.integer  "zip"
  end

  add_index "services", ["city_id"], name: "index_services_on_city_id", using: :btree
  add_index "services", ["state_id"], name: "index_services_on_state_id", using: :btree
  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

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
    t.string   "name",                                   null: false
    t.string   "phone",                                  null: false
    t.integer  "state_id"
    t.integer  "city_id"
    t.boolean  "author"
  end

  add_index "users", ["city_id"], name: "index_users_on_city_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["state_id"], name: "index_users_on_state_id", using: :btree

  add_foreign_key "cities", "states"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "job_agencies", "cities"
  add_foreign_key "job_agencies", "states"
  add_foreign_key "job_agencies", "users"
  add_foreign_key "jobs", "cities"
  add_foreign_key "jobs", "states"
  add_foreign_key "jobs", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "re_agencies", "cities"
  add_foreign_key "re_agencies", "states"
  add_foreign_key "re_agencies", "users"
  add_foreign_key "re_commercials", "cities"
  add_foreign_key "re_commercials", "states"
  add_foreign_key "re_commercials", "users"
  add_foreign_key "re_privates", "cities"
  add_foreign_key "re_privates", "states"
  add_foreign_key "re_privates", "users"
  add_foreign_key "sales", "cities"
  add_foreign_key "sales", "states"
  add_foreign_key "sales", "users"
  add_foreign_key "services", "cities"
  add_foreign_key "services", "states"
  add_foreign_key "services", "users"
  add_foreign_key "users", "cities"
  add_foreign_key "users", "states"
end
