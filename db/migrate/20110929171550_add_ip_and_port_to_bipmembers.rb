class AddIpAndPortToBipmembers < ActiveRecord::Migration
  def self.up
    add_column :bipmembers, :ip, :string
    add_column :bipmembers, :port, :string
  end

  def self.down
    remove_column :bipmembers, :port
    remove_column :bipmembers, :ip
  end
end
