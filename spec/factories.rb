FactoryGirl.define do
	factory :user do
		first_name	"Ben"
		last_name		"Dover"
		email				"ben.dover@gmail.com"
		password 		"foobar"
		password_confirmation "foobar"
	end
end
