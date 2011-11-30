class AddContactIdtoVirtual < ActiveRecord::Migration
  def self.up
    add_column :virtuals, :contact_id, :integer
  end

  def self.down
    remove_column :virtuals, :contact_id
  end
end
