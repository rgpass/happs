namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(first_name: "Gerry", last_name: "Pass", 
			email: "rgpass@gmail.com", password: "foobar", 
			password_confirmation: "foobar", admin: true)
		99.times do |n|
			first_name	= Faker::Name.first_name
			last_name		= Faker::Name.last_name
			email				= Faker::Internet.email
			password 		= "foobar"
			User.create!(first_name: first_name, last_name: last_name, email: email,
				password: password, password_confirmation: password)
		end
	end
end
