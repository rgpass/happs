FactoryGirl.define do
	factory :user do
		sequence(:first_name)	{ |n| "First#{n}" }
		sequence(:last_name)	{ |n| "Last#{n}" }
		sequence(:email)			{ |n| "person_#{n}@happs.io" }
		password 		"foobar"
		password_confirmation "foobar"

		factory :admin do
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
end
