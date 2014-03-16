class Staffmenuship < ActiveRecord::Base
  belongs_to :staff
  belongs_to :menu
end
