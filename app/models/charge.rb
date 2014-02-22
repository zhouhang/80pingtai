class Charge < Transaction

  belongs_to :user
  belongs_to :staff
  #validates :pay_method,presence: true,
  #:inclusion => {in: %w(abc icbc ccb tenpay),:message => I18n.t('errors.messages.pay_method_invalid')}
  validates :total, presence: true, confirmation: true, numericality: {greater_than:0}

  before_create do
    self.status='awaiting'
  end

  ACCOUNTS = [
      {abbr:'abc',full_name:'中国农业银行',owner:'刘军',account:'6228480058024461871'},
      {abbr:'icbc',full_name:'中国工商银行',owner:'刘军',account:'6222023202050348894'},
      {abbr:'ccb',full_name:'中国建设银行',owner:'刘军',account:'6217002870009828334'},
      {abbr:'tenpay',full_name:'财付通',owner:'武汉雷骏风驰科技有限公司',account:'1215786801'}
  ]

  def cancel
    self.update_attribute(:status,'cancelled')
  end

  def confirm(admin)
    Charge.transaction do
      self.user.increment(:credit,self.total)
      self.user.save
      self.status ='completed'
      self.staff = admin
      self.save!
    end
  end

  def self.pay_method_selector
    ACCOUNTS.inject([]) do |r,a|
      r << ("#{a[:full_name]}(#{a[:owner]})(#{a[:account]}),#{a[:abbr]}").split(',')
    end
    #[
    #    ['中国农业银行（刘军）(6228480058024461871)','abc'],
    #    ['中国工商银行（刘军）(6222023202050348894)','icbc'],
    #    ['中国建设银行（刘军）(6217002870009828334)','ccb']
    #]
  end

  def pay_method_display_bank
    a =ACCOUNTS.find {|a|a[:abbr] == self.pay_method}
    a[:full_name] if a.present?
  end

  def pay_method_display_account
    a =ACCOUNTS.find {|a|a[:abbr] == self.pay_method}
    a[:account] if a.present?
  end

end
