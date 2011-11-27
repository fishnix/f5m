class CreateContactvirtuals < ActiveRecord::Migration
  def self.up
    create_table :contactvirtuals do |t|
      t.integer :contact_id
      t.integer :virtual_id
      t.integer :bip_config_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contactvirtuals
  end
end
