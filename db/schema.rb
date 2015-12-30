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

ActiveRecord::Schema.define(version: 20150417231131) do

  create_table "artists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rg_name"
  end

  create_table "feature_counts", force: true do |t|
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_artist_id"
    t.integer  "featured_artist_id"
  end

  create_table "producer_counts", force: true do |t|
    t.integer  "count"
    t.integer  "artist_id"
    t.integer  "producer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "producer_counts", ["artist_id"], name: "index_producer_counts_on_artist_id"
  add_index "producer_counts", ["producer_id"], name: "index_producer_counts_on_producer_id"

  create_table "producers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
