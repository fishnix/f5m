class Bippool < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :bip_config
  has_many :bipmembers
  has_many :bipnodes, :through => :bipmembers
end
