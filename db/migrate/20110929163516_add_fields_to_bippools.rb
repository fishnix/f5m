class AddFieldsToBippools < ActiveRecord::Migration
  def self.up
    add_column :bippools, :lbmethod, :string
    add_column :bippools, :members, :text
    add_column :bippools, :monitors, :text
  end

  def self.down
    remove_column :bippools, :monitors
    remove_column :bippools, :members
    remove_column :bippools, :lbmethod
  end
end
