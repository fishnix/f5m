class AddFieldsToBipselfips < ActiveRecord::Migration
  def self.up
    add_column :bipselfips, :netmask, :string
    add_column :bipselfips, :unit, :integer
    add_column :bipselfips, :floating, :boolean
    add_column :bipselfips, :vlan, :string
  end

  def self.down
    remove_column :bipselfips, :vlan
    remove_column :bipselfips, :floating
    remove_column :bipselfips, :unit
    remove_column :bipselfips, :netmask
  end
end
