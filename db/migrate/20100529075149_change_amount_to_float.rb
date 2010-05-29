class ChangeAmountToFloat < ActiveRecord::Migration
  def self.up
    change_table :wins do |t|
      t.change :amount, :float
    end
  end

  def self.down
    change_table :wins do |t|
      t.change :amount, :integer
    end
  end
end
