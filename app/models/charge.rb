class Charge < ActiveRecord::Base

  attr_reader :total_confirmation

  belongs_to :user
  #validates :pay_method,presence: true,
  # :inclusion => {in: %w(icbc tenpay),:message => I18n.t('errors.messages.pay_method_invalid')}
  validates :total, presence: true, confirmation: true, numericality: {greater_than:0}
  validates :total_confirmation, presence: true, numericality: {greater_than:0}

  def total_confirmation=(val)
    @total_confirmation = val.to_f
  end
end
