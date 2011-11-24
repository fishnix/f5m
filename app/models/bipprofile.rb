class Bipprofile < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :bip_config
  has_many :virtuals, :through => :bipprofilevirtuals
  has_many :bipprofilevirtuals
end
