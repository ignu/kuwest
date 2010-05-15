class CreateWins < ActiveRecord::Migration
  def self.up
    create_table :wins do |t|
      t.integer :amount
      t.string :noun
      t.string :verb

      t.timestamps
    end
  end

  def self.down
    drop_table :wins
  end
end
