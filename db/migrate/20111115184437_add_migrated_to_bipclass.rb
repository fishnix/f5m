class AddMigratedToBipclass < ActiveRecord::Migration
  def self.up
    add_column :bipclasses, :migrated, :boolean
  end

  def self.down
    remove_column :bipclasses, :migrated
  end
end
