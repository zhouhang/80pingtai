# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

staff =Staff.create!(login:'admin',name:'管理员',password:'111111',password_confirmation:'111111')
a = User.create({login:'test',name:'测试1',password:'111111',password_confirmation:'111111'})
a.company = a.build_company(:name=>'时代通讯', :manager=>'张三', :cell_phone=>'13800138000',:telphone=>'0271111111', :address=>'汉阳区钟家村')
a.staff = staff
a.staff_id = staff.id
a.save