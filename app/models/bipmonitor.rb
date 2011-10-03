class Bipmonitor < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :bip_config
  has_many :bippoolmonitors
  has_many :bippools, :through =>:bippoolmonitors
end
