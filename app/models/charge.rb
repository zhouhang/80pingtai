class Charge < ActiveRecord::Base

  belongs_to :user
  #validates :pay_method,presence: true,
  # :inclusion => {in: %w(icbc tenpay),:message => I18n.t('errors.messages.pay_method_invalid')}
  validates :total, presence: true, confirmation: true, numericality: {greater_than:0}

end
