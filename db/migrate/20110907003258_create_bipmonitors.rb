class CreateBipmonitors < ActiveRecord::Migration
  def self.up
    create_table :bipmonitors do |t|
      t.string :name
      t.text :content
      t.integer :bip_config_id
      t.timestamps
    end
  end

  def self.down
    drop_table :bipmonitors
  end
end
