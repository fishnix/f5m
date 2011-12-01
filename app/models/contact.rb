class Contact < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :presence => true
  has_many :virtuals
  
  def contact_name
    "#{name}"
  end
  
end
