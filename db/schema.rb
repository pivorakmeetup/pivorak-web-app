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

ActiveRecord::Schema.define(version: 20170410190943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "authentication_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_authentication_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_authentication_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_authentication_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "authorization_users", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.boolean  "admin",      default: false, null: false
    t.boolean  "verified",   default: false, null: false
    t.boolean  "synthetic",  default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "donations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.decimal  "amount",     precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "payment_id"
    t.index ["goal_id"], name: "index_donations_on_goal_id", using: :btree
    t.index ["payment_id"], name: "index_donations_on_payment_id", using: :btree
    t.index ["user_id"], name: "index_donations_on_user_id", using: :btree
  end

  create_table "email_templates", force: :cascade do |t|
    t.string   "title"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "note"
  end

  create_table "emails", force: :cascade do |t|
    t.string   "subject"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.text     "agenda"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "cover"
    t.boolean  "published",             default: false
    t.integer  "status",                default: 0
    t.integer  "venue_id"
    t.integer  "limit_total",           default: 0,     null: false
    t.integer  "limit_verified",        default: 0,     null: false
    t.text     "facebook_embeded_post"
    t.index ["slug"], name: "index_events_on_slug", using: :btree
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

  create_table "friends", force: :cascade do |t|
    t.string   "name"
    t.integer  "group_id"
    t.string   "logo"
    t.string   "link"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "goals", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.decimal  "amount",      precision: 10, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["slug"], name: "index_goals_on_slug", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "resource"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.string  "uid"
    t.string  "provider"
    t.integer "user_id"
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.string   "searchable_type"
    t.integer  "searchable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree
  end

  create_table "profiling_users", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "email",      null: false
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "slug"
    t.string   "cover"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "talks", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.string   "video_url"
    t.string   "slides_url"
    t.integer  "event_id"
    t.integer  "speaker_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "group_id"
    t.boolean  "published",   default: false
    t.index ["event_id"], name: "index_talks_on_event_id", using: :btree
    t.index ["slug"], name: "index_talks_on_slug", using: :btree
    t.index ["speaker_id"], name: "index_talks_on_speaker_id", using: :btree
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "map_url"
    t.string   "description"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["slug"], name: "index_venues_on_slug", using: :btree
  end

  create_table "visit_requests", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "waiting_list", default: false
    t.boolean  "visited",      default: false
    t.uuid     "token",        default: -> { "uuid_generate_v4()" }
  end

end
