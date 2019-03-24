# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_323_181_951) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'
  enable_extension 'uuid-ossp'

  create_table 'bb_books', id: :serial, force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.integer 'member_id'
    t.integer 'status', default: 0
    t.index ['member_id'], name: 'index_bb_books_on_member_id'
    t.index ['status'], name: 'index_bb_books_on_status'
  end

  create_table 'bb_members', id: :serial, force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'status', default: 0
    t.datetime 'membered_at'
    t.index ['status'], name: 'index_bb_members_on_status'
    t.index ['user_id'], name: 'index_bb_members_on_user_id'
  end

  create_table 'courses_assessments', id: :serial, force: :cascade do |t|
    t.integer 'interview_assessment_id'
    t.integer 'question_id'
    t.integer 'mark'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['interview_assessment_id'], name: 'index_courses_assessments_on_interview_assessment_id'
    t.index ['question_id'], name: 'index_courses_assessments_on_question_id'
  end

  create_table 'courses_homeworks', id: :serial, force: :cascade do |t|
    t.integer 'student_id'
    t.string 'git_url'
    t.string 'showcase_url'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'lecture_id'
    t.index ['lecture_id'], name: 'index_courses_homeworks_on_lecture_id'
    t.index ['student_id'], name: 'index_courses_homeworks_on_student_id'
  end

  create_table 'courses_interview_assessments', id: :serial, force: :cascade do |t|
    t.integer 'interview_id'
    t.integer 'mentor_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['interview_id'], name: 'index_courses_interview_assessments_on_interview_id'
  end

  create_table 'courses_interviews', id: :serial, force: :cascade do |t|
    t.integer 'mentor_id'
    t.integer 'student_id'
    t.datetime 'start_at'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'season_id'
    t.string 'video_url'
    t.integer 'status', default: 0
  end

  create_table 'courses_lectures', id: :serial, force: :cascade do |t|
    t.string 'title'
    t.string 'slug'
    t.text 'description'
    t.datetime 'started_at'
    t.datetime 'finished_at'
    t.integer 'status'
    t.integer 'venue_id'
    t.integer 'season_id'
    t.integer 'mentor_id'
    t.index ['mentor_id'], name: 'index_courses_lectures_on_mentor_id'
    t.index ['season_id'], name: 'index_courses_lectures_on_season_id'
    t.index ['slug'], name: 'index_courses_lectures_on_slug'
    t.index ['venue_id'], name: 'index_courses_lectures_on_venue_id'
  end

  create_table 'courses_progress', id: :serial, force: :cascade do |t|
    t.integer 'student_id'
    t.integer 'lecture_id'
    t.integer 'mentor_id'
    t.decimal 'homework_mark', precision: 4, scale: 2
    t.integer 'lecture_presence', default: 0
    t.index ['lecture_id'], name: 'index_courses_progress_on_lecture_id'
    t.index ['mentor_id'], name: 'index_courses_progress_on_mentor_id'
    t.index ['student_id'], name: 'index_courses_progress_on_student_id'
  end

  create_table 'courses_questions', id: :serial, force: :cascade do |t|
    t.string 'body'
    t.integer 'season_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'courses_seasons', id: :serial, force: :cascade do |t|
    t.string 'title'
    t.string 'slug'
    t.text 'description'
    t.datetime 'start_at'
    t.datetime 'finish_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'status', default: 0
    t.index ['slug'], name: 'index_courses_seasons_on_slug'
  end

  create_table 'courses_students', id: :serial, force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'season_id'
    t.integer 'status', default: 0
    t.text 'personal_info'
    t.text 'motivation_info'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'experience_info'
    t.text 'devote_info'
    t.text 'notes'
    t.index ['user_id'], name: 'index_courses_students_on_user_id'
  end

  create_table 'courses_test_tasks', id: :serial, force: :cascade do |t|
    t.integer 'student_id'
    t.string 'git_url'
    t.string 'showcase_url'
    t.text 'comment'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'mentor_id'
    t.integer 'status', default: 0
  end

  create_table 'donations', id: :serial, force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'goal_id'
    t.decimal 'amount', precision: 10, scale: 2
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'payment_id'
    t.index ['goal_id'], name: 'index_donations_on_goal_id'
    t.index ['payment_id'], name: 'index_donations_on_payment_id'
    t.index ['user_id'], name: 'index_donations_on_user_id'
  end

  create_table 'email_templates', id: :serial, force: :cascade do |t|
    t.string 'title'
    t.string 'subject'
    t.text 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'note'
  end

  create_table 'emails', id: :serial, force: :cascade do |t|
    t.string 'subject'
    t.string 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'events', id: :serial, force: :cascade do |t|
    t.string 'title'
    t.string 'slug'
    t.text 'description'
    t.text 'agenda'
    t.datetime 'started_at'
    t.datetime 'finished_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'cover'
    t.boolean 'published', default: false
    t.integer 'status', default: 0
    t.integer 'venue_id'
    t.integer 'limit_total', default: 0, null: false
    t.integer 'limit_verified', default: 0, null: false
    t.text 'facebook_embeded_post'
    t.index ['slug'], name: 'index_events_on_slug'
  end

  create_table 'friendly_id_slugs', id: :serial, force: :cascade do |t|
    t.string 'slug', null: false
    t.integer 'sluggable_id', null: false
    t.string 'sluggable_type', limit: 50
    t.string 'scope'
    t.datetime 'created_at'
    t.index %w[slug sluggable_type scope], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope', unique: true
    t.index %w[slug sluggable_type], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type'
    t.index ['sluggable_id'], name: 'index_friendly_id_slugs_on_sluggable_id'
    t.index ['sluggable_type'], name: 'index_friendly_id_slugs_on_sluggable_type'
  end

  create_table 'friends', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.integer 'group_id'
    t.string 'logo'
    t.string 'link'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'published', default: false
  end

  create_table 'goals', id: :serial, force: :cascade do |t|
    t.string 'title'
    t.string 'slug'
    t.text 'description'
    t.decimal 'amount', precision: 10, scale: 2
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['slug'], name: 'index_goals_on_slug'
  end

  create_table 'groups', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.string 'resource'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'slug'
    t.index ['slug'], name: 'index_groups_on_slug', unique: true
  end

  create_table 'identities', id: :serial, force: :cascade do |t|
    t.string 'uid'
    t.string 'provider'
    t.integer 'user_id'
    t.index ['user_id'], name: 'index_identities_on_user_id'
  end

  create_table 'pages', id: :serial, force: :cascade do |t|
    t.string 'title'
    t.string 'url'
    t.text 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'pg_search_documents', id: :serial, force: :cascade do |t|
    t.text 'content'
    t.string 'searchable_type'
    t.integer 'searchable_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[searchable_type searchable_id], name: 'index_pg_search_documents_on_searchable_type_and_searchable_id'
  end

  create_table 'season_mentors', id: :serial, force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'season_id'
    t.index ['season_id'], name: 'index_season_mentors_on_season_id'
    t.index ['user_id'], name: 'index_season_mentors_on_user_id'
  end

  create_table 'taggings', id: :serial, force: :cascade do |t|
    t.integer 'tag_id'
    t.string 'taggable_type'
    t.integer 'taggable_id'
    t.string 'tagger_type'
    t.integer 'tagger_id'
    t.string 'context', limit: 128
    t.datetime 'created_at'
    t.index ['context'], name: 'index_taggings_on_context'
    t.index %w[tag_id taggable_id taggable_type context tagger_id tagger_type], name: 'taggings_idx', unique: true
    t.index ['tag_id'], name: 'index_taggings_on_tag_id'
    t.index %w[taggable_id taggable_type context], name: 'index_taggings_on_taggable_id_and_taggable_type_and_context'
    t.index %w[taggable_id taggable_type tagger_id context], name: 'taggings_idy'
    t.index ['taggable_id'], name: 'index_taggings_on_taggable_id'
    t.index ['taggable_type'], name: 'index_taggings_on_taggable_type'
    t.index %w[tagger_id tagger_type], name: 'index_taggings_on_tagger_id_and_tagger_type'
    t.index ['tagger_id'], name: 'index_taggings_on_tagger_id'
  end

  create_table 'tags', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.integer 'taggings_count', default: 0
    t.index ['name'], name: 'index_tags_on_name', unique: true
  end

  create_table 'talks', id: :serial, force: :cascade do |t|
    t.string 'title'
    t.string 'slug'
    t.text 'description'
    t.string 'video_url'
    t.string 'slides_url'
    t.integer 'event_id'
    t.integer 'speaker_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'group_id'
    t.boolean 'published', default: false
    t.string 'cover'
    t.jsonb 'extra', default: {}
    t.index ['event_id'], name: 'index_talks_on_event_id'
    t.index ['slug'], name: 'index_talks_on_slug'
    t.index ['speaker_id'], name: 'index_talks_on_speaker_id'
  end

  create_table 'users', id: :serial, force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'admin', default: false
    t.string 'first_name'
    t.string 'last_name'
    t.boolean 'synthetic', default: false
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'slug'
    t.boolean 'verified', default: false
    t.string 'cover'
    t.boolean 'subscribed', default: true
    t.boolean 'supervisor', default: false
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['slug'], name: 'index_users_on_slug'
  end

  create_table 'venues', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.string 'address'
    t.string 'map_url'
    t.string 'description'
    t.string 'slug'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['slug'], name: 'index_venues_on_slug'
  end

  create_table 'visit_requests', id: :serial, force: :cascade do |t|
    t.integer 'event_id'
    t.integer 'user_id'
    t.integer 'status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'waiting_list', default: false
    t.boolean 'visited', default: false
    t.uuid 'token', default: -> { 'uuid_generate_v4()' }
    t.datetime 'checked_in_at'
  end
end
