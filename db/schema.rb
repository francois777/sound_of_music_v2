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

ActiveRecord::Schema.define(version: 20150428014848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "approvals", force: :cascade do |t|
    t.integer  "approval_status",  default: 0
    t.integer  "rejection_reason", default: 0
    t.integer  "approvable_id"
    t.string   "approvable_type"
    t.integer  "approver_id",      default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "approvals", ["approvable_id", "approvable_type"], name: "index_approvals_on_approvable_id_and_approvable_type", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.integer  "publishable_id"
    t.string   "publishable_type"
    t.integer  "author_id",        null: false
    t.integer  "theme_id",         null: false
    t.text     "body"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "articles", ["author_id"], name: "index_article_author", using: :btree
  add_index "articles", ["publishable_id", "publishable_type"], name: "index_articles_on_publishable_id_and_publishable_type", using: :btree

  create_table "artist_contribution", force: :cascade do |t|
    t.integer  "artist_id",            null: false
    t.integer  "contribution_type_id", null: false
    t.text     "comment"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "artist_contribution", ["artist_id", "contribution_type_id"], name: "index_artist_contribution_pk", using: :btree
  add_index "artist_contribution", ["artist_id"], name: "index_contribution_by_artist_id", using: :btree

  create_table "artist_names", force: :cascade do |t|
    t.integer "artist_id"
    t.string  "name"
    t.integer "name_type"
  end

  add_index "artist_names", ["name"], name: "index_artist_names_on_name", using: :btree

  create_table "artists", force: :cascade do |t|
    t.datetime "born_on"
    t.datetime "died_on"
    t.string   "assigned_name",                        null: false
    t.string   "born_country_code",    default: ""
    t.integer  "historical_period_id", default: 0
    t.integer  "gender",               default: 0
    t.integer  "submitted_by_id",                      null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "group",                default: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "contribution_types", force: :cascade do |t|
    t.string  "definition"
    t.integer "classification", default: 11
    t.integer "group_type",     default: 0
    t.integer "voice_type",     default: 1
  end

  create_table "historical_periods", force: :cascade do |t|
    t.string "name"
    t.date   "period_from"
    t.date   "period_end"
    t.text   "overview"
  end

  create_table "instruments", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id",     default: 0
    t.integer  "subcategory_id",  default: 0
    t.boolean  "tuned",           default: false
    t.string   "other_names",     default: ""
    t.string   "performer_title", default: ""
    t.string   "origin_period",   default: ""
    t.integer  "created_by_id",                   null: false
    t.integer  "last_image_id",   default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "title"
    t.string   "image_name"
    t.integer  "submitted_by_id", default: 0
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "image"
    t.integer  "bytes"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "photos", ["imageable_id", "imageable_type"], name: "index_photos_on_imageable_id_and_imageable_type", using: :btree
  add_index "photos", ["submitted_by_id"], name: "index_photo_submitted_by", using: :btree

  create_table "subcategories", force: :cascade do |t|
    t.string  "name"
    t.integer "category_id"
  end

  create_table "themes", force: :cascade do |t|
    t.integer "subject"
    t.string  "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             default: "",    null: false
    t.string   "last_name",              default: "",    null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "role"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
