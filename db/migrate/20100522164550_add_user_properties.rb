class AddUserProperties < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string
    add_column :users, :first_name, :string    
    add_column :users, :last_name, :string    
  end

  def self.down
    drop_column :users, :username
    drop_column :users, :first_name
    drop_column :users, :last_name
  end
end
