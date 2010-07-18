class AddObjectiveToQuest < ActiveRecord::Migration
  def self.up
    create_table :objectives do |t|
      t.string    :name
      t.integer   :amount
      t.string    :noun
      t.string    :verb
      t.integer   :quest_id
      t.string    :past_tense_verb
    end
    add_column    :quests, :user_id, :integer
    add_index     :objectives, :quest_id
    add_index     :quests, :user_id
  end

  def self.down
    drop_table :objectives
    remove_index :quests, :user_id
    remove_column :quests, :user_id
  end
end
