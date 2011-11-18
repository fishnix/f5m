class AddMigratedToBipmember < ActiveRecord::Migration
  def self.up
    add_column :bipmembers, :migrated, :boolean
  end

  def self.down
    remove_column :bipmembers, :migrated
  end
end
