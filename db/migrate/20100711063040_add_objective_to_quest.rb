class AddObjectiveToQuest < ActiveRecord::Migration
  def self.up
    create_table :objectives do |t|
      t.integer   :amount
      t.string    :noun
      t.string    :verb
      t.integer   :quest_id
      t.integer   :user_id
    end
    add_index :objectives, [:user_id, :quest_id]
  end

  def self.down
    drop_table :objectives
  end
end
