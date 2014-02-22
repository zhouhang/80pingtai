class Fundslog < ActiveRecord::Base
  belongs_to :staff
  belongs_to :user
  belongs_to    :transaction

  def self.create_for_transaction tran
    self.create do |fund|
      fund.desc = tran.remark
      fund.money = tran.total
      fund.cur_money = tran.user.credit
      fund.cur_commission = tran.user.commission
      fund.staff = tran.user.staff
      fund.user = tran.user
      fund.transaction = tran
    end
  end

end
