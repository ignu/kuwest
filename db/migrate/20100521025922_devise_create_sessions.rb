class DeviseCreateSessions < ActiveRecord::Migration
  def self.up
    create_table(:sessions) do |t|
      t.database_authenticatable :null => false
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      # t.lockable

      t.timestamps
    end

    add_index :sessions, :email,                :unique => true
    add_index :sessions, :confirmation_token,   :unique => true
    add_index :sessions, :reset_password_token, :unique => true
    # add_index :sessions, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :sessions
  end
end
