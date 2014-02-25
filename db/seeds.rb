# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

staff =Staff.create!(login:'admin',name:'管理员',password:'111111',password_confirmation:'111111')
a = User.create({login:'test',name:'测试1',password:'111111',password_confirmation:'111111',credit:1000})
a.company = a.build_company(:name=>'时代通讯', :manager=>'张三', :cell_phone=>'13800138000',:telphone=>'0271111111', :address=>'汉阳区钟家村')
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


=begin
csv_text = File.read("#{Rails.root}/db/locations.csv")
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  if $.< 10
    Location.create!(row.to_hash)
  end
end
=end
