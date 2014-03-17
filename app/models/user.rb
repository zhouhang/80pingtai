class User < ActiveRecord::Base

  #attr_accessible :name, :email, :password, :password_confirmation

  attr_accessor :password_confirmation, :password_old,:staff_id
  attr_accessor :business_password_confirmation, :business_password_old

  has_secure_password
  belongs_to :company#,inverse_of: :user
  belongs_to :staff
  accepts_nested_attributes_for  :company
  before_save :set_default_business_password

  validates :name, :presence => true
  #validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}
  validates :password, :presence => true, :length => { :minimum => 6 }, confirmation: true, :on => :create
  validates :password, length: {:minimum => 6}, on: :update, allow_blank: true
  validates :staff_id, :presence => true,:on => :create
  validate :staff_valid, :on => :create
  def self.find_by_remember_token(token)
    user = where(:_id => token.split('$').first).first
    (user && user.remember_token == token) ? user : nil
  end

  def staff_id=(val)
    @staff_id = val.to_i
  end

  def company_for_form
    company ? company : build_company
  end

  def staff_valid
    if staff_id.blank? ||Staff.find_by_id(staff_id).blank?
      errors.add(:staff_id, I18n.t('errors.messages.is_not_match'))
    end
  end

  def set_default_business_password
    if self.business_password.blank?
      self.business_password = '666666'
    end
  end

  def grant_commission total
    self.increment(:commission,total)
    self.save!
    Commission.create do |c|
      c.total = total
      c.user = self
      c.status = 'completed'
    end
  end

  def role_human
    a = [{code: 'user',name: '非会员'},{code: 'member', name: '会员'}].select do |c|
    c[:code] == self.role
    end
    a.first[:name]
  end

  def grant_fee total
    self.increment(:credit,total)
    self.save!
  end

  def use total
    self.increment(:credit,-total)
    self.save!
  end

end
