# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
gerry = User.create(first_name: "Gerry", last_name: "Pass", 
	email: "rgpass@gmail.com", password: "foobar", 
	password_confirmation: "foobar")

gerry.toggle!(:admin)
