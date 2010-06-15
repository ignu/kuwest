class AddXpToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :xp, :integer
  end

  def self.down
    remove_column :users, :xp
  end
end
