class BipConfig < ActiveRecord::Base
  has_many :virtuals,         :dependent => :destroy
  has_many :bippools,         :dependent => :destroy
  has_many :bipnodes,         :dependent => :destroy
  has_many :bipmonitors,      :dependent => :destroy
  has_many :bipmembers,       :dependent => :destroy
  has_many :bipselfips,       :dependent => :destroy
  has_many :bipclasses,       :dependent => :destroy
  has_many :biprules,         :dependent => :destroy
  has_many :bippoolmonitors,  :dependent => :destroy
  has_many :bippoolvirtuals,  :dependent => :destroy
  has_many :virtualrules,     :dependent => :destroy
end
