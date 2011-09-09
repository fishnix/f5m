class Bipmember < ActiveRecord::Base
  belongs_to :pool
  belongs_to :node
end
