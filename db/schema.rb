# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100717191234) do

  create_table "comments", :force => true do |t|
    t.string   "body"
    t.integer  "win_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"
  add_index "comments", ["win_id"], :name => "index_comments_on_win_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "followings", :force => true do |t|
    t.integer  "follower_id",  :null => false
    t.integer  "following_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "objectives", :force => true do |t|
    t.string  "name"
    t.integer "amount"
    t.string  "noun"
    t.string  "verb"
    t.integer "quest_definition_id"
    t.string  "past_tense_verb"
  end

  add_index "objectives", ["quest_definition_id"], :name => "index_objectives_on_quest_id"

  create_table "quest_definitions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "quest_definitions", ["user_id"], :name => "index_quests_on_user_id"

  create_table "quest_objectives", :force => true do |t|
    t.string  "noun"
    t.string  "verb"
    t.integer "amount"
    t.integer "completed"
    t.integer "quest_id"
    t.integer "objective_id"
    t.integer "target1"
    t.integer "target2"
    t.integer "target3"
  end

  add_index "quest_objectives", ["noun"], :name => "index_quest_objectives_on_noun"
  add_index "quest_objectives", ["quest_id"], :name => "index_quest_objectives_on_quest_id"
  add_index "quest_objectives", ["verb"], :name => "index_quest_objectives_on_verb"

  create_table "quests", :force => true do |t|
    t.string   "why"
    t.integer  "quest_definition_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quests", ["quest_definition_id"], :name => "index_quests_on_quest_definition_id"

  create_table "sessions", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["confirmation_token"], :name => "index_sessions_on_confirmation_token", :unique => true
  add_index "sessions", ["email"], :name => "index_sessions_on_email", :unique => true
  add_index "sessions", ["reset_password_token"], :name => "index_sessions_on_reset_password_token", :unique => true

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.boolean  "public_name"
    t.string   "location"
    t.string   "bio"
    t.string   "url"
    t.string   "twitter_name"
    t.boolean  "image_processing"
    t.integer  "xp"
    t.boolean  "allow_email"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wins", :force => true do |t|
    t.float    "amount"
    t.string   "noun"
    t.string   "verb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  add_index "wins", ["user_id"], :name => "index_wins_on_user_id"

end
