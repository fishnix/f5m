class AddColsToBipnode < ActiveRecord::Migration
  def self.up
    add_column :bipnodes, :dyn_ratio, :integer
    add_column :bipnodes, :limit, :integer
    add_column :bipnodes, :ratio, :integer
    add_column :bipnodes, :monitor, :string
    add_column :bipnodes, :screen, :string
    add_column :bipnodes, :updown, :boolean
  end

  def self.down
    remove_column :bipnodes, :updown
    remove_column :bipnodes, :screen
    remove_column :bipnodes, :monitor
    remove_column :bipnodes, :ratio
    remove_column :bipnodes, :limit
    remove_column :bipnodes, :dyn_ratio
  end
end
