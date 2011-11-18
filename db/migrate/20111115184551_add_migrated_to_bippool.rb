class AddMigratedToBippool < ActiveRecord::Migration
  def self.up
    add_column :bippools, :migrated, :boolean
  end

  def self.down
    remove_column :bippools, :migrated
  end
end
