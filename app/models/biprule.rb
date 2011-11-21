class Biprule < ActiveRecord::Base
  validates :name, :presence => true
  has_many :virtuals, :through => :virtualrules
  belongs_to :bip_config
end
