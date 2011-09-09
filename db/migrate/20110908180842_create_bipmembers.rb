class CreateBipmembers < ActiveRecord::Migration
  def self.up
    create_table :bipmembers do |t|
      t.string :name
      t.integer :bipnode_id
      t.integer :bippool_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bipmembers
  end
end
