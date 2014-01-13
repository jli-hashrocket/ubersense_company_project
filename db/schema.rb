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

ActiveRecord::Schema.define(:version => 20131202220708) do

  create_table "accounts", :force => true do |t|
    t.string   "email"
    t.string   "hashed_pwd"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "invite_recipients", :force => true do |t|
    t.integer  "invite_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "fbid"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "invite_recipients", ["invite_id"], :name => "index_invite_recipients_on_invite_id"

  create_table "invites", :force => true do |t|
    t.integer  "account_id"
    t.string   "product_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "message"
    t.integer  "video_id"
    t.string   "signature"
    t.string   "subject"
  end

  add_index "invites", ["account_id"], :name => "index_invites_on_account_id"

  create_table "people", :force => true do |t|
    t.string   "guId"
    t.integer  "account_id"
    t.string   "email"
    t.integer  "fbid",       :limit => 8
    t.string   "name"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "people", ["account_id"], :name => "index_people_on_account_id"
  add_index "people", ["email"], :name => "index_people_on_email"
  add_index "people", ["fbid"], :name => "index_people_on_fbid"
  add_index "people", ["guId"], :name => "index_people_on_guId"

  create_table "teammates", :force => true do |t|
    t.integer  "account_id"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end
end
