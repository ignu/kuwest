class AddEmailToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :allow_email, :boolean
  end

  def self.down
    remove_column :users, :allow_email
  end
end
