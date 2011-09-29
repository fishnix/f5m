# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110929171550) do

  create_table "bip_configs", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bipclasses", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "bip_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bipmembers", :force => true do |t|
    t.string   "name"
    t.integer  "bipnode_id"
    t.integer  "bippool_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bip_config_id"
    t.string   "ip"
    t.string   "port"
  end

  create_table "bipmonitors", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "bip_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bipnodes", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "bip_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dyn_ratio"
    t.integer  "limit"
    t.integer  "ratio"
    t.string   "monitor"
    t.string   "screen"
    t.boolean  "updown"
  end

  create_table "bippools", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "bip_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lbmethod"
    t.text     "members"
    t.text     "monitors"
  end

  create_table "biprules", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "bip_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bipselfips", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "bip_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "netmask"
    t.integer  "unit"
    t.boolean  "floating"
    t.string   "vlan"
  end

  create_table "virtuals", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "bip_config_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
