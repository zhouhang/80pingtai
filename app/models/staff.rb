class Staff < ActiveRecord::Base

  attr_accessor :password_confirmation

  has_secure_password

  validates :name, :presence => true
  #validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}
  validates :password, :length => { :minimum => 6 }, confirmation: true, :on => :create
  validates :password_confirmation, presence: true
  validates_length_of :password, :minimum => 6

  def self.find_by_remember_token(token)
    user = where(:_id => token.split('$').first).first
    (user && user.remember_token == token) ? user : nil
  end

end

