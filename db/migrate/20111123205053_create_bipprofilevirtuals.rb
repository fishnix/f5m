class CreateBipprofilevirtuals < ActiveRecord::Migration
  def self.up
    create_table :bipprofilevirtuals do |t|
      t.integer :bipprofile_id
      t.integer :virtual_id
      t.integer :bip_config_id
    end
  end

  def self.down
    drop_table :bipprofilevirtuals
  end
end
