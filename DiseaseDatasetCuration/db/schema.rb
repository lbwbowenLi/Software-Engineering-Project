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

ActiveRecord::Schema.define(version: 20161203033617) do

  create_table "datasets", force: :cascade do |t|
    t.string   "name"
    t.text     "Data_set"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diseases", force: :cascade do |t|
    t.string   "disease"
    t.string   "accession"
    t.text     "questions"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "related",    default: 0
    t.integer  "unrelated",  default: 0
    t.boolean  "closed",     default: false
  end

  create_table "fullquestions", force: :cascade do |t|
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.text     "qcontent",     default: "Default question description", null: false
    t.string   "qanswer"
    t.string   "ds_name"
    t.string   "ds_accession"
    t.boolean  "closed",       default: false
    t.integer  "yes_users",    default: 0
    t.integer  "no_users",     default: 0
  end

  create_table "fullsubmissions", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "fullquestion_id"
    t.string   "choice"
    t.text     "reason"
  end

  add_index "fullsubmissions", ["fullquestion_id"], name: "index_fullsubmissions_on_fullquestion_id"
  add_index "fullsubmissions", ["user_id"], name: "index_fullsubmissions_on_user_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "group_level", default: "graduate"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "admin_uid"
    t.text     "data_set"
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  add_index "groups_users", ["group_id"], name: "index_groups_users_on_group_id"
  add_index "groups_users", ["user_id"], name: "index_groups_users_on_user_id"

  create_table "partsearchresults", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "keyword"
    t.text     "Data_set_results"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.float    "accuracy",          default: 0.0
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "group_admin",       default: false
    t.boolean  "addquestion_admin", default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
