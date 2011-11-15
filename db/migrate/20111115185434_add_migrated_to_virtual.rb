class AddMigratedToVirtual < ActiveRecord::Migration
  def self.up
    add_column :virtuals, :migrated, :boolean
  end

  def self.down
    remove_column :virtuals, :migrated
  end
end
