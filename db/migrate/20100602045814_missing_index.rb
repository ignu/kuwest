class MissingIndex < ActiveRecord::Migration
  def self.up
    add_index :comments, :win_id
    add_index :comments, :user_id    
    add_index :wins, :user_id        
  end

  def self.down
    remove_index :comments, :win_id
    remove_index :comments, :user_id    
    remove_index :wins, :user_id
  end
end
