class AddMigratedToBipmonitor < ActiveRecord::Migration
  def self.up
    add_column :bipmonitors, :migrated, :boolean
  end

  def self.down
    remove_column :bipmonitors, :migrated
  end
end
