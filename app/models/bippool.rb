class Bippool < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :bip_config
  has_many :members
  has_many :nodes, :through => :members
end
