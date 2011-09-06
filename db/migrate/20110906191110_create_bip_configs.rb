class CreateBipConfigs < ActiveRecord::Migration
  def self.up
    create_table :bip_configs do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :bip_configs
  end
end
