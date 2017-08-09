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

ActiveRecord::Schema.define(version: 20170809144929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "actionable_type"
    t.bigint "actionable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actionable_type", "actionable_id"], name: "index_actions_on_actionable_type_and_actionable_id"
  end

  create_table "answers", id: :serial, force: :cascade do |t|
    t.text "text"
    t.integer "user_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "title"
    t.boolean "paid", default: false
    t.integer "votes_count", default: 0
    t.string "cached_tags", default: ""
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["slug"], name: "index_answers_on_slug"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "state_id"
    t.string "slug"
    t.string "state_slug"
    t.index ["slug"], name: "index_cities_on_slug"
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "commentable_type"
    t.integer "commentable_id"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "phone"
    t.string "vk"
    t.string "fb"
    t.string "google"
    t.string "site"
    t.string "skype"
    t.string "street"
    t.bigint "state_id"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_contacts_on_city_id"
    t.index ["state_id"], name: "index_contacts_on_state_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "kind", null: false
    t.string "name", null: false
    t.string "title", null: false
    t.string "country", null: false
    t.string "city", null: false
    t.integer "start_year", null: false
    t.integer "end_year"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_experiences_on_user_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "listings", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.string "category"
    t.string "subcategory"
    t.string "token"
    t.boolean "active", default: true, null: false
    t.integer "priority", default: 0
    t.boolean "featured", default: false
    t.integer "user_id"
    t.integer "state_id"
    t.integer "city_id"
    t.string "street"
    t.float "lat"
    t.float "lng"
    t.integer "zip"
    t.string "phone"
    t.string "email"
    t.string "site"
    t.string "vk"
    t.string "fb"
    t.string "gl"
    t.string "duration"
    t.integer "price"
    t.integer "baths"
    t.integer "space"
    t.string "rooms"
    t.boolean "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.string "from_name"
    t.string "legend", default: "", null: false
    t.index ["city_id"], name: "index_listings_on_city_id"
    t.index ["state_id"], name: "index_listings_on_state_id"
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "pg_search_documents", id: :serial, force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.integer "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "pictures", id: :serial, force: :cascade do |t|
    t.integer "imageable_id"
    t.string "imageable_type"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.boolean "logo"
    t.integer "user_id"
    t.datetime "created_at", default: "2016-10-07 07:19:18", null: false
    t.datetime "updated_at", default: "2016-10-07 07:19:18", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"
    t.index ["user_id"], name: "index_pictures_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cached_tags", default: "", null: false
    t.string "slug", default: "", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.text "text", default: ""
    t.integer "user_id"
    t.integer "answers_count", default: 0
    t.string "slug"
    t.string "cached_tags"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["slug"], name: "index_questions_on_slug", unique: true
    t.index ["title"], name: "index_questions_on_title"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "reviews", id: :serial, force: :cascade do |t|
    t.integer "listing_id"
    t.integer "user_id"
    t.integer "rating", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["listing_id", "user_id"], name: "index_reviews_on_listing_id_and_user_id", unique: true
    t.index ["listing_id"], name: "index_reviews_on_listing_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "states", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "abbr"
    t.string "slug"
    t.index ["slug"], name: "index_states_on_slug"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "role", default: ""
    t.string "short_bio"
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text "about", default: ""
    t.datetime "last_seen"
    t.string "gender", default: "male", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.integer "votable_id"
    t.string "votable_type"
    t.integer "voter_id"
    t.string "voter_type"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "cities", "states"
  add_foreign_key "comments", "users"
  add_foreign_key "contacts", "cities"
  add_foreign_key "contacts", "states"
  add_foreign_key "contacts", "users"
  add_foreign_key "experiences", "users"
  add_foreign_key "listings", "cities"
  add_foreign_key "listings", "states"
  add_foreign_key "listings", "users"
  add_foreign_key "pictures", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "reviews", "users"
end
