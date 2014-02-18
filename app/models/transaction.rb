class Transaction < ActiveRecord::Base
	STATUS =[
    {name:'等待处理',code:'awaiting'},
    {name:'处理完成',code:'completed'}
  ]
  belongs_to :user

  before_save :generate_number

  def status_display
    a = STATUS.find { |s| s[:code] == status }
    a[:name] if a.present?
  end

  def generate_number
    record = true
      while record
        random = "#{Date.today.year-2012}#{Array.new(8){rand(10)}.join}"
        record = self.class.where(:number => random).first
      end
      self.number = random if self.number.blank?
      self.number
  end


end
