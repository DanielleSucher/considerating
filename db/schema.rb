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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120203235017) do

  create_table "considerations", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "votes_count",                               :default => 0,   :null => false
    t.decimal  "votes_total", :precision => 4, :scale => 2, :default => 0.0, :null => false
  end

  add_index "considerations", ["user_id", "created_at"], :name => "index_considerations_on_uid_and_created_at"
  add_index "considerations", ["user_id"], :name => "index_considerations_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "admin",      :default => false
    t.boolean  "banned",     :default => false
  end

  create_table "votes", :force => true do |t|
    t.integer  "voter_id"
    t.integer  "voted_id"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.decimal  "rating",     :precision => 4, :scale => 2, :default => 0.0, :null => false
  end

  add_index "votes", ["voted_id"], :name => "index_votes_on_voted_id"
  add_index "votes", ["voter_id", "voted_id"], :name => "index_votes_on_voter_id_and_voted_id", :unique => true
  add_index "votes", ["voter_id"], :name => "index_votes_on_voter_id"

end
