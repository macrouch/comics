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

ActiveRecord::Schema.define(version: 20150707213951) do

  create_table "characters", force: true do |t|
    t.string   "cv_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters_collected_editions", force: true do |t|
    t.integer "collected_edition_id"
    t.integer "character_id"
  end

  create_table "characters_issues", force: true do |t|
    t.integer "issue_id"
    t.integer "character_id"
  end

  create_table "collected_editions", force: true do |t|
    t.string   "name"
    t.string   "volume_number"
    t.integer  "volume_id"
    t.string   "cv_id"
    t.string   "site_detail_url"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.string   "cover_file_size"
    t.string   "cover_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: true do |t|
    t.integer  "user_id"
    t.integer  "issue_id"
    t.string   "variant_name"
    t.string   "variant_file_name"
    t.string   "variant_content_type"
    t.integer  "variant_file_size"
    t.datetime "variant_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "collected_edition_id"
  end

  create_table "creators", id: false, force: true do |t|
    t.integer  "issue_id"
    t.integer  "person_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "collected_edition_id"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "issues", force: true do |t|
    t.string   "cv_id"
    t.string   "issue_number"
    t.string   "name"
    t.string   "site_detail_url"
    t.datetime "store_date"
    t.integer  "volume_id"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "cv_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publishers", force: true do |t|
    t.string   "cv_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "volume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  create_table "volumes", force: true do |t|
    t.string   "cv_id"
    t.string   "name"
    t.integer  "start_year"
    t.integer  "publisher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
