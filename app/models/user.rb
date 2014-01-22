class User < ActiveRecord::Base

  #attr_accessible :name, :email, :password, :password_confirmation

  attr_accessor :password_confirmation, :password_old
  attr_accessor :business_password_confirmation, :business_password_old

  has_secure_password
  has_one :company#,inverse_of: :user
  accepts_nested_attributes_for  :company

  validates :name, :presence => true
  #validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}
  validates :password, :length => { :minimum => 6 }, confirmation: true, :on => :create
  validates :password_confirmation, presence: true
  validates_length_of :password, :minimum => 6

  def self.find_by_remember_token(token)
    user = where(:_id => token.split('$').first).first
    (user && user.remember_token == token) ? user : nil
  end

  def is_admin?
    return self.role == 'admin'
  end


  def company_for_form
    company ? company : build_company
  end

end
