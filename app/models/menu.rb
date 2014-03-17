class Menu < ActiveRecord::Base
  has_many :staffmenuships
  has_many :staffs, :through => :staffmenuships
end
