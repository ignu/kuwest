class CreateQuestDefinitionModel < ActiveRecord::Migration
  def self.up
    rename_table :quests, :quest_definitions

    create_table :quests do |t|
      t.string        :why
      t.integer       :quest_definition_id
      t.integer       :user_id
      t.timestamps
    end

    create_table :quest_objectives do |t|
      t.string  :noun
      t.string  :verb
      t.integer :amount
      t.integer :completed
      t.integer :quest_id
      t.integer :objective_id
      t.integer :target1
      t.integer :target2
      t.integer :target3
    end

    add_index   :quests,           :quest_definition_id
    add_index   :quest_objectives, :quest_id
    add_index   :quest_objectives, :noun
    add_index   :quest_objectives, :verb
    rename_column :objectives, :quest_id, :quest_definition_id
  end


  def self.down
    drop_table      :quest_objectives
    drop_table      :quests
    rename_table    :quest_definitions, :quests
  end
end
