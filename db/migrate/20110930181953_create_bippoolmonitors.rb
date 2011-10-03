class CreateBippoolmonitors < ActiveRecord::Migration
  def self.up
    create_table :bippoolmonitors do |t|
      t.integer :bippool_id
      t.integer :bipmonitor_id
      t.integer :bip_config_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bippoolmonitors
  end
end
