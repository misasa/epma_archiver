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

ActiveRecord::Schema.define(version: 20150421083406) do

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.string   "path"
    t.float    "center_x"
    t.float    "center_y"
    t.float    "center_z"
    t.integer  "pixels_x"
    t.integer  "pixels_y"
    t.float    "pixels_size_x"
    t.float    "pixels_size_y"
    t.string   "zip_file_name"
    t.string   "zip_content_type"
    t.integer  "zip_file_size"
    t.datetime "zip_updated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "magnification"
    t.datetime "mtime"
  end

  create_table "maps", force: :cascade do |t|
    t.string   "path"
    t.integer  "area_id"
    t.string   "element_name"
    t.string   "channel"
    t.string   "crystal_name"
    t.string   "x_ray_name"
    t.text     "info"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "mtime",              null: false
    t.datetime "ctime",              null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "signal"
  end

end
