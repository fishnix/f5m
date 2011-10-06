class CreateBippoolvirtuals < ActiveRecord::Migration
  def self.up
    create_table :bippoolvirtuals do |t|
      t.integer :bippool_id
      t.integer :virtual_id
      t.integer :bip_config_id
    end
  end

  def self.down
    drop_table :bippoolvirtuals
  end
end
