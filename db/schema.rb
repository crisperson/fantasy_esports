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

ActiveRecord::Schema.define(version: 20140502202316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fantasy_teams", force: true do |t|
    t.string   "tname"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fantasy_teams", ["user_id", "created_at"], name: "index_fantasy_teams_on_user_id_and_created_at", using: :btree

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.string   "tag"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "leagues", ["name"], name: "index_leagues_on_name", unique: true, using: :btree
  add_index "leagues", ["tag"], name: "index_leagues_on_tag", unique: true, using: :btree

  create_table "players", force: true do |t|
    t.string   "name"
    t.string   "aka"
    t.integer  "age"
    t.string   "location"
    t.float    "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "tag"
    t.string   "leader"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["name"], name: "index_teams_on_name", unique: true, using: :btree
  add_index "teams", ["tag"], name: "index_teams_on_tag", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "aka"
    t.string   "last_login"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["aka"], name: "index_users_on_aka", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
