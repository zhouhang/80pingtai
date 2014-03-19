# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

staff =Staff.create!(login:'admin',name:'管理员',phone:'13006159174',password:'111111',password_confirmation:'111111',status:1)
a = User.create({login:'test',name:'测试1',password:'111111',password_confirmation:'111111',credit:1000,role:'user'})
a.company = a.build_company(:name=>'时代通讯', :manager=>'张三', :cell_phone=>'13800138000',:telphone=>'0271111111', :address=>'汉阳区钟家村')
a.staff = staff
a.staff_id = staff.id
a.save
a = User.create({login:'test1',name:'测试2',password:'111111',password_confirmation:'111111',credit:0,role:'user'})
a.company = a.build_company(:name=>'世纪通讯', :manager=>'李四', :cell_phone=>'10086',:telphone=>'027222222', :address=>'汉口江汉路')
a.staff = staff
a.staff_id = staff.id
a.save

Webapi.create!(name:'千行',pinyin:'qianxing')
Webapi.create!(name:'高阳',pinyin:'gaoyang')
Webapi.create!(name:'鲲鹏',pinyin:'kunpeng')
Webapi.create!(name:'易赛',pinyin:'esai')
Webapi.create!(name:'鑫宇',pinyin:'xinyu')

Channel.create!(name:'本地湖北联通',area:'169,170,171,172,173,174,175,176,177,178,179',operator_id:'1',denomination:'10,20,30,50,100,200,300,500',business:'1',status:'1',price_id:'1',webapi_id:'1')
Workid.create!(name:'abc',password:'123456',business_password:'111111',priority:'1',day_limit:'1000',business:["0","1",""],status:'1',channel_id:'1')

Channel.create!(name:'本地湖北移动',area:'169,170,171,172,173,174,175,176,177,178,179',operator_id:'0',denomination:'10,20,30,50,100,200,300,500',business:'1',status:'1',price_id:'1',webapi_id:'2')
Workid.create!(name:'cde',password:'123456',business_password:'111111',priority:'1',day_limit:'1000',business:["0","1",""],status:'1',channel_id:'2')

Price.create!(name:'湖北电信',price:100,agent_price:99,member_price:98,status:1)

#operator_id为运营商id，0移动，1联通，2电信
Channelgroup.create!(province_id:17,city_id:169,operator_id:1)
Channelgroupship.create!(channel_id:1,order:1,channelgroup_id:1)

Channelgroup.create!(province_id:17,city_id:169,operator_id:0)
Channelgroupship.create!(channel_id:2,order:1,channelgroup_id:2)

Location.create(:number => '1860715',:city => '湖北省武汉市',:isp =>'联通',:zip_code => '027')
Location.create(:number => '1500278',:city => '湖北省武汉市',:isp =>'移动',:zip_code => '027')

Menu.create!(:name => '代理商资料', :path => '/users')
Menu.create!(:name => '通道设置', :path => '/channels')
Menu.create!(:name => '通道分组设置', :path => '/channelgroups')
Menu.create!(:name => '工号设置', :path => '/workids')
Menu.create!(:name => '游戏通道设置', :path => '#')
Menu.create!(:name => '代理商充值价格管理', :path => '/prices')
Menu.create!(:name => '游戏充值进价管理', :path => '#')
Menu.create!(:name => '订单页面查询', :path => '/phones')
Menu.create!(:name => '游戏订单查询', :path => '#')
Menu.create!(:name => '存款请求处理', :path => '/charges')
Menu.create!(:name => '代理商资金动向', :path => '#')
Menu.create!(:name => '代理商加/扣款', :path => '#')
Menu.create!(:name => '通道充值成功失败笔数统计', :path => '/phones/getby?condition=channel')
Menu.create!(:name => '代理商充值统计', :path => '/phones/getby?condition=user')
Menu.create!(:name => '充值工号充值统计', :path => '/phones/getby?condition=workid')
Menu.create!(:name => '代理商年充值总额,运营商每年充值总额', :path => '#')
Menu.create!(:name => '用户每月增减量', :path => '#')
Menu.create!(:name => '公告管理', :path => '/announcements')
Menu.create!(:name => '业务员管理', :path => '/staffs')

=begin
csv_text = File.read("#{Rails.root}/db/locations.csv")
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  if $.< 10
    Location.create!(row.to_hash)
  end
end
=end
