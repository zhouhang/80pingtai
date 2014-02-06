class Transaction < ActiveRecord::Base
	STATUS =[
    {name:'等待处理',code:'awaiting'},
    {name:'处理完成',code:'completed'}
  ]
  belongs_to :user
  def status_display
    a = STATUS.find { |s| s[:code] == status }
    a[:name] if a.present?
  end

end
