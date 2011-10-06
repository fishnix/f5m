class Virtual < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :bip_config
  has_many :bippools, :through => :bippoolvirtuals
  has_many :bippoolvirtuals
end
