class AddFieldsToBipmembers < ActiveRecord::Migration
  def self.up
    add_column :bipmembers, :bip_config_id, :integer
  end

  def self.down
    remove_column :bipmembers, :bip_config_id
  end
end
