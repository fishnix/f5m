class CreateBipprofiles < ActiveRecord::Migration
  def self.up
    create_table :bipprofiles do |t|
      t.string :name
      t.string :ptype
      t.text :content
      t.integer :bip_config_id
      t.boolean :migrated

      t.timestamps
    end
  end

  def self.down
    drop_table :bipprofiles
  end
end
