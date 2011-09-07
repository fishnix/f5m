class CreateBiprules < ActiveRecord::Migration
  def self.up
    create_table :biprules do |t|
      t.string :name
      t.text :content
      t.integer :bip_config_id
      t.timestamps
    end
  end

  def self.down
    drop_table :biprules
  end
end
