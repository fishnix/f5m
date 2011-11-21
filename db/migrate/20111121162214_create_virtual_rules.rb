class CreateVirtualRules < ActiveRecord::Migration
  def self.up
    create_table :virtualrules do |t|
      t.integer :virtual_id
      t.integer :biprule_id      
      t.integer :bip_config_id
    end
  end

  def self.down
    drop_table :virtualrules
  end
end
