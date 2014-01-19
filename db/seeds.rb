# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:'test',password:'111111',password_confirmation:'111111',email:'test@pingtai.com')
User.create!(name:'admin',password:'111111',password_confirmation:'111111',email:'admin@pingtai.com',role:'admin')