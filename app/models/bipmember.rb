class Bipmember < ActiveRecord::Base
  belongs_to :bippool
  belongs_to :bipnode
end
