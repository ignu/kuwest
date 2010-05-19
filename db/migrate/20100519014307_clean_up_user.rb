class CleanUpUser < ActiveRecord::Migration
  def self.up
		drop_table "users"
		create_table :users do |t|
			t.database_authenticatable
			t.confirmable
			t.recoverable
			t.rememberable
			t.trackable
			t.timestamps
		end
  end

  def self.down
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
  end
end
