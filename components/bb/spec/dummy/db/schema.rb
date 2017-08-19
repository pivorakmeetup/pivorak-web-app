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

ActiveRecord::Schema.define(version: 20170819113459) do

  create_table "bb_members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "membered_at"
    t.index ["status"], name: "index_bb_members_on_status"
    t.index ["user_id"], name: "index_bb_members_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string  "email"
    t.string  "first_name"
    t.string  "last_name"
    t.boolean "admin",      default: true
  end

end
