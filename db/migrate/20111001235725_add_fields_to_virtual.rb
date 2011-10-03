class AddFieldsToVirtual < ActiveRecord::Migration
  def self.up
    add_column :virtuals, :enable, :boolean
    add_column :virtuals, :destination, :string
    add_column :virtuals, :mask, :string
    add_column :virtuals, :mirror, :boolean
    add_column :virtuals, :limit, :string
    add_column :virtuals, :ip_protocol, :string
    add_column :virtuals, :snat, :string
    add_column :virtuals, :snatpool, :string
    add_column :virtuals, :srcport, :string
    add_column :virtuals, :type, :string
    add_column :virtuals, :pool, :text
    add_column :virtuals, :persist, :string
    add_column :virtuals, :fb_persist, :string
    add_column :virtuals, :profiles, :text
    add_column :virtuals, :rules, :text
    add_column :virtuals, :vlans, :text
    add_column :virtuals, :httpclasses, :text
  end

  def self.down
    remove_column :virtuals, :httpclasses
    remove_column :virtuals, :vlans
    remove_column :virtuals, :rules
    remove_column :virtuals, :profiles
    remove_column :virtuals, :fb_persist
    remove_column :virtuals, :persist
    remove_column :virtuals, :pool
    remove_column :virtuals, :type
    remove_column :virtuals, :srcport
    remove_column :virtuals, :snatpool
    remove_column :virtuals, :snat
    remove_column :virtuals, :ip_protocol
    remove_column :virtuals, :limit
    remove_column :virtuals, :mirror
    remove_column :virtuals, :mask
    remove_column :virtuals, :destination
    remove_column :virtuals, :enable
  end
end
