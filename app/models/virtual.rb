class Virtual < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :bip_config
end
