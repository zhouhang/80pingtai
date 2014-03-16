class Staff < ActiveRecord::Base

  attr_accessor :password_confirmation

  has_many :staffmenuships
  has_many :menus, :through => :staffmenuships

  has_many :fundslogs

  has_secure_password
  #has_many :users
  before_validation :set_default_password

  validates :name, :presence => true
  #validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}
  validates :password, :length => { :minimum => 6 }, confirmation: true, :on => :create
  validates :password_confirmation, presence: true
  validates_length_of :password, :minimum => 6
  validate :is_staff_exist, :on => :create

  def self.find_by_remember_token(token)
    user = where(:_id => token.split('$').first).first
    (user && user.remember_token == token) ? user : nil
  end

  def set_default_password
    if self.password.blank?
      self.password = '666666'
    end
    if self.password_confirmation.blank?
      self.password_confirmation = '666666'
    end
    if self.status.blank?
      self.status = 1
    end
  end

  def is_staff_exist
    if !Staff.where(:login => login).blank?
      errors.add(:login, I18n.t('errors.messages.is_exist'))
    end
  end

end

