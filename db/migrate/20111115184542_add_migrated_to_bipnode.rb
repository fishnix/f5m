class AddMigratedToBipnode < ActiveRecord::Migration
  def self.up
    add_column :bipnodes, :migrated, :boolean
  end

  def self.down
    remove_column :bipnodes, :migrated
  end
end
