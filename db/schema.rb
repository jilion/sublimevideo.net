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

ActiveRecord::Schema.define(:version => 20121205172815) do

  create_table "tailor_made_player_requests", :force => true do |t|
    t.string   "name",                    :null => false
    t.string   "email",                   :null => false
    t.string   "topic",                   :null => false
    t.string   "job_title"
    t.string   "company"
    t.string   "url"
    t.string   "country"
    t.string   "token"
    t.string   "topic_standalone_detail"
    t.string   "topic_other_detail"
    t.text     "description",             :null => false
    t.string   "document"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "highrise_kase_id"
  end

  add_index "tailor_made_player_requests", ["created_at"], :name => "index_tailor_made_player_requests_on_created_at"
  add_index "tailor_made_player_requests", ["topic"], :name => "index_tailor_made_player_requests_on_topic"

end
