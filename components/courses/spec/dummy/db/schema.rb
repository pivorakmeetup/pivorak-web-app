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

ActiveRecord::Schema.define(version: 20170718183113) do

  create_table "courses_homeworks", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "git_url"
    t.string   "showcase_url"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["student_id"], name: "index_courses_homeworks_on_student_id"
  end

  create_table "courses_interviews", force: :cascade do |t|
    t.integer  "mentor_id"
    t.integer  "student_id"
    t.datetime "start_at"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "season_id"
  end

  create_table "courses_lectures", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "status"
    t.integer  "venue_id"
    t.integer  "season_id"
    t.integer  "mentor_id"
    t.index ["mentor_id"], name: "index_courses_lectures_on_mentor_id"
    t.index ["season_id"], name: "index_courses_lectures_on_season_id"
    t.index ["slug"], name: "index_courses_lectures_on_slug"
    t.index ["venue_id"], name: "index_courses_lectures_on_venue_id"
  end

  create_table "courses_questions", force: :cascade do |t|
    t.string   "body"
    t.integer  "season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses_seasons", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "status"
    t.index ["slug"], name: "index_courses_seasons_on_slug"
  end

  create_table "courses_students", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "season_id"
    t.integer  "status",          default: 0
    t.text     "personal_info"
    t.text     "motivation_info"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_courses_students_on_user_id"
  end

  create_table "season_mentors", force: :cascade do |t|
    t.integer "user_id"
    t.integer "season_id"
    t.index ["season_id"], name: "index_season_mentors_on_season_id"
    t.index ["user_id"], name: "index_season_mentors_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
