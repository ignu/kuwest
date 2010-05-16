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

ActiveRecord::Schema.define(:version => 20100516160204) do

  create_table "users", :force => true do |t|
    t.string   "login",               :null => false
    t.string   "email",               :null => false
    t.string   "crypted_password",    :null => false
    t.string   "password_salt",       :null => false
    t.string   "persistance_token",   :null => false
    t.string   "single_access_token", :null => false
    t.string   "perishable_token",    :null => false
    t.integer  "login_count",         :null => false
    t.integer  "failed_login_count",  :null => false
    t.datetime "last_request_at",     :null => false
    t.datetime "current_login_at",    :null => false
    t.datetime "last_login_at",       :null => false
    t.string   "current_login_ip",    :null => false
    t.string   "last_login_ip",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wins", :force => true do |t|
    t.integer  "amount"
    t.string   "noun"
    t.string   "verb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

end
