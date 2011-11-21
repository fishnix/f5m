class Virtualrule < ActiveRecord::Base
  belongs_to :virtual
  belongs_to :biprule
end