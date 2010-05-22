class CreateQuests < ActiveRecord::Migration
  def self.up
    create_table :quests do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :quests
  end
end
