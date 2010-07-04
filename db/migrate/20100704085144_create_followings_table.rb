class CreateFollowingsTable < ActiveRecord::Migration
  def self.up
    create_table :followings do |t|
      t.integer :follower_id, :null => false
      t.integer :following_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :followings
  end
end
