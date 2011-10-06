class Bippool < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :bip_config
  has_many :bipmembers
  has_many :bipnodes, :through => :bipmembers
  has_many :bippoolmonitors
  has_many :bipmonitors, :through => :bippoolmonitors
  has_many :virtuals, :through => :bippoolvirtuals
  has_many :bippoolvirtuals
end
  