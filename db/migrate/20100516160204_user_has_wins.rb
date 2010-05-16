class UserHasWins < ActiveRecord::Migration
  def self.up
    add_column :wins, :user_id, :integer
  end

  def self.down
    remove_column :wins, :user_id
  end
end
