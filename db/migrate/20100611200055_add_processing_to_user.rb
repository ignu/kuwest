class AddProcessingToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :image_processing, :boolean
  end

  def self.down
    remove_column :users, :image_processing
  end
end
