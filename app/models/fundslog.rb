class Fundslog < ActiveRecord::Base
  belongs_to :staff
  belongs_to :user

  def self.get_staff(staff_id)
    staff = Staff.find staff_id
    staff_name = staff.login
  end

  def save_log
    @fundslog = Fundslog.new( :user_id => 1, :staff_id => 1, :desc => 'desc', :money => 10.0, :cur_money => 20.0, :cur_commission => 5.0 )
    @fundslog.save
  end

end
