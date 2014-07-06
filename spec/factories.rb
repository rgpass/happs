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
end
