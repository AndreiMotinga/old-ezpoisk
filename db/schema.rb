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

ActiveRecord::Schema.define(version: 20160506190517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "impressions_count", default: 0
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string  "name"
    t.integer "state_id"
  end

  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree
  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.string  "post_id"
    t.string  "post_type"
    t.boolean "favorite"
    t.boolean "hidden"
  end

  add_index "favorites", ["user_id", "post_id", "post_type", "favorite"], name: "quadro_index_on_favorite", unique: true, using: :btree
  add_index "favorites", ["user_id", "post_id", "post_type", "hidden"], name: "quadro_index_on_hidden", unique: true, using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "grumpy_dogs", force: :cascade do |t|
  end

  create_table "horoscopes", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "day_description"
    t.string   "month_description"
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.string   "phone"
    t.string   "email"
    t.string   "category"
    t.text     "description",       default: "", null: false
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
    t.string   "street"
    t.integer  "impressions_count", default: 0
    t.string   "slug"
    t.string   "source"
  end

  add_index "jobs", ["category"], name: "index_jobs_on_category", using: :btree
  add_index "jobs", ["city_id"], name: "index_jobs_on_city_id", using: :btree
  add_index "jobs", ["slug"], name: "index_jobs_on_slug", unique: true, using: :btree
  add_index "jobs", ["state_id"], name: "index_jobs_on_state_id", using: :btree
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "partners", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "link"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title"
    t.string   "position",           default: ""
    t.string   "page"
    t.date     "start_date"
    t.date     "active_until"
    t.integer  "amount"
  end

  add_index "partners", ["user_id"], name: "index_partners_on_user_id", using: :btree

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
    t.integer  "user_id"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree
  add_index "pictures", ["user_id"], name: "index_pictures_on_user_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "title"
    t.string   "name"
    t.integer  "amount"
    t.string   "currency"
    t.string   "interval"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "text",               default: "",   null: false
    t.integer  "user_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "image_remote_url"
    t.integer  "impressions_count",  default: 0
    t.string   "slug"
    t.string   "link"
    t.boolean  "visible",            default: true
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                default: ""
    t.string   "phone",               default: ""
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "site",                default: ""
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer  "impressions_count",   default: 0,  null: false
    t.text     "about",               default: "", null: false
    t.text     "work",                default: "", null: false
    t.string   "street",              default: "", null: false
    t.string   "facebook",            default: "", null: false
    t.string   "google",              default: "", null: false
    t.string   "vk",                  default: "", null: false
    t.string   "ok",                  default: "", null: false
    t.string   "twitter",             default: "", null: false
    t.string   "motto",               default: "", null: false
    t.float    "lat"
    t.float    "lng"
    t.integer  "zip"
  end

  add_index "profiles", ["city_id"], name: "index_profiles_on_city_id", using: :btree
  add_index "profiles", ["state_id"], name: "index_profiles_on_state_id", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "text",              default: ""
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "impressions_count", default: 0
    t.integer  "answers_count",     default: 0
    t.string   "slug"
    t.string   "image_url",         default: ""
  end

  add_index "questions", ["slug"], name: "index_questions_on_slug", unique: true, using: :btree
  add_index "questions", ["title"], name: "index_questions_on_title", using: :btree
  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "re_commercials", force: :cascade do |t|
    t.string   "category",          default: "",    null: false
    t.string   "street",            default: "",    null: false
    t.string   "post_type",         default: "",    null: false
    t.string   "phone",             default: "",    null: false
    t.integer  "price",                             null: false
    t.integer  "space"
    t.integer  "zip"
    t.float    "lat"
    t.float    "lng"
    t.boolean  "active",            default: false
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "description",       default: "",    null: false
    t.integer  "impressions_count", default: 0
    t.string   "email"
  end

  add_index "re_commercials", ["category"], name: "index_re_commercials_on_category", using: :btree
  add_index "re_commercials", ["city_id"], name: "index_re_commercials_on_city_id", using: :btree
  add_index "re_commercials", ["price"], name: "index_re_commercials_on_price", using: :btree
  add_index "re_commercials", ["space"], name: "index_re_commercials_on_space", using: :btree
  add_index "re_commercials", ["state_id"], name: "index_re_commercials_on_state_id", using: :btree
  add_index "re_commercials", ["user_id"], name: "index_re_commercials_on_user_id", using: :btree

  create_table "re_privates", force: :cascade do |t|
    t.string   "street",            default: "",    null: false
    t.string   "post_type",         default: "",    null: false
    t.string   "duration",          default: "",    null: false
    t.string   "phone",             default: "",    null: false
    t.integer  "price",                             null: false
    t.integer  "baths"
    t.integer  "space"
    t.string   "rooms",                             null: false
    t.integer  "zip"
    t.float    "lat"
    t.float    "lng"
    t.boolean  "active",            default: false
    t.boolean  "fee",               default: false
    t.text     "description",       default: "",    null: false
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "impressions_count", default: 0
    t.string   "source"
    t.string   "email"
  end

  add_index "re_privates", ["city_id"], name: "index_re_privates_on_city_id", using: :btree
  add_index "re_privates", ["price"], name: "index_re_privates_on_price", using: :btree
  add_index "re_privates", ["space"], name: "index_re_privates_on_space", using: :btree
  add_index "re_privates", ["state_id"], name: "index_re_privates_on_state_id", using: :btree
  add_index "re_privates", ["user_id"], name: "index_re_privates_on_user_id", using: :btree

  create_table "sales", force: :cascade do |t|
    t.string   "title"
    t.string   "category"
    t.string   "phone"
    t.string   "email"
    t.text     "description",       default: "", null: false
    t.boolean  "active"
    t.float    "lat"
    t.float    "lng"
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "zip"
    t.string   "street"
    t.string   "price"
    t.integer  "impressions_count", default: 0
    t.string   "slug"
  end

  add_index "sales", ["city_id"], name: "index_sales_on_city_id", using: :btree
  add_index "sales", ["description"], name: "index_sales_on_description", using: :btree
  add_index "sales", ["slug"], name: "index_sales_on_slug", unique: true, using: :btree
  add_index "sales", ["state_id"], name: "index_sales_on_state_id", using: :btree
  add_index "sales", ["title"], name: "index_sales_on_title", using: :btree
  add_index "sales", ["user_id"], name: "index_sales_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "title"
    t.string   "street"
    t.string   "phone"
    t.string   "email"
    t.string   "site"
    t.string   "category"
    t.string   "subcategory"
    t.text     "description",       default: "", null: false
    t.integer  "user_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.float    "lat"
    t.float    "lng"
    t.integer  "zip"
    t.string   "slug",              default: ""
    t.string   "fax"
    t.integer  "impressions_count", default: 0
    t.date     "active_until"
    t.boolean  "active"
  end

  add_index "services", ["city_id"], name: "index_services_on_city_id", using: :btree
  add_index "services", ["state_id"], name: "index_services_on_state_id", using: :btree
  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abbr"
  end

  add_index "states", ["abbr"], name: "index_states_on_abbr", unique: true, using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subscriptions", ["question_id"], name: "index_subscriptions_on_question_id", using: :btree
  add_index "subscriptions", ["user_id", "question_id"], name: "index_subscriptions_on_user_id_and_question_id", unique: true, using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

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
    t.string   "role",                   default: ""
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "slug"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "cities", "states"
  add_foreign_key "favorites", "users"
  add_foreign_key "jobs", "cities"
  add_foreign_key "jobs", "states"
  add_foreign_key "jobs", "users"
  add_foreign_key "partners", "users"
  add_foreign_key "pictures", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "profiles", "cities"
  add_foreign_key "profiles", "states"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "users"
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
  add_foreign_key "subscriptions", "questions"
  add_foreign_key "subscriptions", "users"
end
