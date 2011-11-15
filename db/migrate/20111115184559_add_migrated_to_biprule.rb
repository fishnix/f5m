class AddMigratedToBiprule < ActiveRecord::Migration
  def self.up
    add_column :biprules, :migrated, :boolean
  end

  def self.down
    remove_column :biprules, :migrated
  end
end
