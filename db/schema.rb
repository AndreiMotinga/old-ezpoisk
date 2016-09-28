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

ActiveRecord::Schema.define(version: 20160928022630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "impressions_count",  default: 0
    t.string   "slug"
    t.integer  "visits",             default: 0
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "paid",               default: false
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
    t.index ["user_id"], name: "index_answers_on_user_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string  "name"
    t.integer "state_id"
    t.index ["name"], name: "index_cities_on_name", using: :btree
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "entries", force: :cascade do |t|
    t.string   "enterable_type"
    t.integer  "enterable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.index ["enterable_type", "enterable_id"], name: "index_entries_on_enterable_type_and_enterable_id", using: :btree
    t.index ["user_id"], name: "index_entries_on_user_id", using: :btree
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "favorable_id"
    t.string  "favorable_type"
    t.boolean "saved",          default: false, null: false
    t.boolean "hidden",         default: false, null: false
    t.index ["user_id", "favorable_id", "favorable_type", "hidden"], name: "quadro_index_on_hidden", unique: true, using: :btree
    t.index ["user_id", "favorable_id", "favorable_type", "saved"], name: "quadro_index_on_favorite", unique: true, using: :btree
    t.index ["user_id"], name: "index_favorites_on_user_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "galleries", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_galleries_on_user_id", using: :btree
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
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
    t.index ["user_id"], name: "index_impressions_on_user_id", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "title"
    t.string   "phone"
    t.string   "email"
    t.string   "category"
    t.text     "text",              default: "",    null: false
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
    t.integer  "visits",            default: 0
    t.string   "token"
    t.integer  "priority",          default: 0,     null: false
    t.string   "vk",                default: ""
    t.string   "fb",                default: ""
    t.boolean  "remote",            default: false
    t.boolean  "featured",          default: false
    t.index ["category"], name: "index_jobs_on_category", using: :btree
    t.index ["city_id"], name: "index_jobs_on_city_id", using: :btree
    t.index ["fb"], name: "index_jobs_on_fb", using: :btree
    t.index ["slug"], name: "index_jobs_on_slug", unique: true, using: :btree
    t.index ["state_id"], name: "index_jobs_on_state_id", using: :btree
    t.index ["user_id"], name: "index_jobs_on_user_id", using: :btree
    t.index ["vk"], name: "index_jobs_on_vk", using: :btree
  end

  create_table "partners", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "url"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title"
    t.string   "text",               default: "",    null: false
    t.string   "position"
    t.integer  "impressions_count",  default: 0,     null: false
    t.integer  "clicks",             default: 0,     null: false
    t.string   "phone"
    t.string   "email"
    t.boolean  "approved",           default: false
    t.integer  "budget"
    t.boolean  "featured",           default: false
    t.index ["user_id"], name: "index_partners_on_user_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "logo"
    t.integer  "user_id"
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree
    t.index ["user_id"], name: "index_pictures_on_user_id", using: :btree
  end

  create_table "points", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "author_id"], name: "index_points_on_user_id_and_author_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_points_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "text",               default: "",    null: false
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "image_remote_url"
    t.integer  "impressions_count",  default: 0
    t.string   "slug"
    t.string   "link"
    t.boolean  "visible",            default: true
    t.string   "category"
    t.text     "summary"
    t.integer  "visits",             default: 0
    t.string   "source"
    t.boolean  "paid",               default: false
    t.index ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string  "title"
    t.text    "text",              default: ""
    t.integer "user_id"
    t.integer "impressions_count", default: 0
    t.integer "answers_count",     default: 0
    t.string  "slug"
    t.string  "image_url",         default: ""
    t.integer "visits",            default: 0
    t.index ["slug"], name: "index_questions_on_slug", unique: true, using: :btree
    t.index ["title"], name: "index_questions_on_title", using: :btree
    t.index ["user_id"], name: "index_questions_on_user_id", using: :btree
  end

  create_table "re_privates", force: :cascade do |t|
    t.string   "street",            default: "",    null: false
    t.string   "post_type",         default: "",    null: false
    t.string   "duration",          default: "",    null: false
    t.string   "phone",             default: "",    null: false
    t.integer  "price"
    t.integer  "baths"
    t.integer  "space"
    t.string   "rooms",                             null: false
    t.integer  "zip"
    t.float    "lat"
    t.float    "lng"
    t.boolean  "active",            default: false
    t.boolean  "fee",               default: false
    t.text     "text",              default: "",    null: false
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "impressions_count", default: 0
    t.string   "email"
    t.integer  "visits",            default: 0
    t.integer  "priority",          default: 0,     null: false
    t.string   "token"
    t.string   "category"
    t.string   "vk",                default: ""
    t.string   "fb",                default: ""
    t.boolean  "featured",          default: false
    t.index ["city_id"], name: "index_re_privates_on_city_id", using: :btree
    t.index ["fb"], name: "index_re_privates_on_fb", using: :btree
    t.index ["price"], name: "index_re_privates_on_price", using: :btree
    t.index ["space"], name: "index_re_privates_on_space", using: :btree
    t.index ["state_id"], name: "index_re_privates_on_state_id", using: :btree
    t.index ["user_id"], name: "index_re_privates_on_user_id", using: :btree
    t.index ["vk"], name: "index_re_privates_on_vk", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "service_id"
    t.integer  "user_id"
    t.integer  "rating",     null: false
    t.text     "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.index ["service_id", "user_id"], name: "index_reviews_on_service_id_and_user_id", unique: true, using: :btree
    t.index ["service_id"], name: "index_reviews_on_service_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "sales", force: :cascade do |t|
    t.string   "title"
    t.string   "category"
    t.string   "phone"
    t.string   "email"
    t.text     "text",              default: "",    null: false
    t.boolean  "active"
    t.float    "lat"
    t.float    "lng"
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "zip"
    t.string   "street"
    t.integer  "impressions_count", default: 0
    t.string   "slug"
    t.integer  "price"
    t.integer  "visits",            default: 0
    t.integer  "priority",          default: 0,     null: false
    t.string   "token"
    t.string   "vk",                default: ""
    t.string   "fb",                default: ""
    t.boolean  "featured",          default: false
    t.index ["city_id"], name: "index_sales_on_city_id", using: :btree
    t.index ["fb"], name: "index_sales_on_fb", using: :btree
    t.index ["slug"], name: "index_sales_on_slug", unique: true, using: :btree
    t.index ["state_id"], name: "index_sales_on_state_id", using: :btree
    t.index ["text"], name: "index_sales_on_text", using: :btree
    t.index ["title"], name: "index_sales_on_title", using: :btree
    t.index ["user_id"], name: "index_sales_on_user_id", using: :btree
    t.index ["vk"], name: "index_sales_on_vk", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "title"
    t.string   "street"
    t.string   "phone"
    t.string   "email"
    t.string   "site"
    t.string   "category"
    t.string   "subcategory"
    t.text     "text",               default: "",    null: false
    t.integer  "user_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.float    "lat"
    t.float    "lng"
    t.integer  "zip"
    t.string   "slug",               default: ""
    t.integer  "impressions_count",  default: 0
    t.integer  "priority",           default: 0,     null: false
    t.integer  "visits",             default: 0
    t.string   "token"
    t.boolean  "active"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "vk"
    t.string   "fb"
    t.string   "google"
    t.string   "twitter"
    t.string   "ok"
    t.boolean  "featured",           default: false
    t.index ["city_id"], name: "index_services_on_city_id", using: :btree
    t.index ["state_id"], name: "index_services_on_state_id", using: :btree
    t.index ["user_id"], name: "index_services_on_user_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abbr"
    t.index ["abbr"], name: "index_states_on_abbr", unique: true, using: :btree
  end

  create_table "stripe_plans", force: :cascade do |t|
    t.string   "name"
    t.string   "stripe_id"
    t.string   "interval"
    t.integer  "amount"
    t.integer  "total"
    t.integer  "priority"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "select_name"
  end

  create_table "stripe_subscriptions", force: :cascade do |t|
    t.integer  "service_id"
    t.string   "customer_id"
    t.string   "sub_id"
    t.datetime "active_until"
    t.string   "status"
    t.string   "plan"
    t.index ["service_id"], name: "index_stripe_subscriptions_on_service_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id"
    t.string  "subscribable_type"
    t.integer "subscribable_id"
    t.index ["subscribable_type", "subscribable_id"], name: "index_subscriptions_on_subscribable_type_and_subscribable_id", using: :btree
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
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
    t.string   "role",                   default: ""
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "slug"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "phone",                  default: ""
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "site",                   default: ""
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.integer  "impressions_count",      default: 0
    t.text     "about",                  default: ""
    t.string   "street",                 default: ""
    t.string   "facebook",               default: ""
    t.string   "google",                 default: ""
    t.string   "vk",                     default: ""
    t.string   "ok",                     default: ""
    t.string   "twitter",                default: ""
    t.float    "lat"
    t.float    "lng"
    t.integer  "zip"
    t.index ["city_id"], name: "index_users_on_city_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["state_id"], name: "index_users_on_state_id", using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "cities", "states"
  add_foreign_key "entries", "users"
  add_foreign_key "favorites", "users"
  add_foreign_key "galleries", "users"
  add_foreign_key "jobs", "cities"
  add_foreign_key "jobs", "states"
  add_foreign_key "jobs", "users"
  add_foreign_key "partners", "users"
  add_foreign_key "pictures", "users"
  add_foreign_key "points", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "re_privates", "cities"
  add_foreign_key "re_privates", "states"
  add_foreign_key "re_privates", "users"
  add_foreign_key "reviews", "services"
  add_foreign_key "reviews", "users"
  add_foreign_key "sales", "cities"
  add_foreign_key "sales", "states"
  add_foreign_key "sales", "users"
  add_foreign_key "services", "cities"
  add_foreign_key "services", "states"
  add_foreign_key "services", "users"
  add_foreign_key "stripe_subscriptions", "services"
  add_foreign_key "subscriptions", "users"
end
