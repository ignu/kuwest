class AddColumnsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :public_name, :boolean
    add_column :users, :location, :string
    add_column :users, :bio, :string
    add_column :users, :url, :string
    add_column :users, :twitter_name, :string    
  end

  def self.down
    remove_column :users, :public_name, :boolean
    remove_column :users, :location, :string
    remove_column :users, :bio, :string
    remove_column :users, :url, :string
    remove_column :users, :twitter_name, :string    
  end
end
