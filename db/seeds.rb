# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(login:'test',name:'测试1',password:'111111',password_confirmation:'111111')
Staff.create!(login:'admin',name:'管理员',password:'111111',password_confirmation:'111111')