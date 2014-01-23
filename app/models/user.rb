class User < ActiveRecord::Base

  #attr_accessible :name, :email, :password, :password_confirmation

  attr_accessor :password_confirmation, :password_old
  attr_accessor :business_password_confirmation, :business_password_old

  has_secure_password
  belongs_to :company#,inverse_of: :user
  accepts_nested_attributes_for  :company

  validates :name, :presence => true
  #validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}
  validates :password, :presence => true, :length => { :minimum => 6 }, confirmation: true, :on => :create
  validates :password, length: {:minimum => 6}, on: :update, allow_blank: true

  def self.find_by_remember_token(token)
    user = where(:_id => token.split('$').first).first
    (user && user.remember_token == token) ? user : nil
  end

  def company_for_form
    company ? company : build_company
  end

end
