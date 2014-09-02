FactoryGirl.define do
	factory :user do
		sequence(:first_name)	{ |n| "First#{n}" }
		sequence(:last_name)	{ |n| "Last#{n}" }
		# sequence(:email)			{ |n| "person-#{n}@gmail.com" }
		email { Faker::Internet.email }
		password 		"foobar"
		password_confirmation "foobar"

		factory :admin, parent: :user do
			email "rgpass@gmail.com"
			admin true
		end
	end

	factory :subjective_happiness_scale do
		general 		(1..7).to_a.sample
		peers				(1..7).to_a.sample
		regardless	(1..7).to_a.sample
		neg					(1..7).to_a.sample
		user
	end

	factory :activity do
		title	"Help an old lady across the street"
		path	"/actofkindness/1"
		category	"Practicing acts of kindness"
		user
	end

	factory :ohq do
		score 90
		user
	end

	factory :pafd do
		gratitude			4.17
		optimism			3
		comparison 		2
		kindness			3.5
		relationships	1.5
		coping 				0.5
		forgiveness 	0
		engagement 		3.5
		joys 					3.83
		goals 				2.17
		spirituality	2.67
		body 					0.83
		user
	end

	factory :gratitude do
		title		"My wife"
		content	"Because she's the bomb dot com"
		user
	end

	factory :joy do
		title "Eating ice cream"
		content "Ate a ridic amount of ice cream and it was delicious"
		user
	end

	factory :kindness do
		title "Helped an old lady"
		content "She was crossing the street looking nervous"
		user
	end

	factory :engagement do
		title "Coding"
		content "Got in the zone with coding"
		user
	end
end
