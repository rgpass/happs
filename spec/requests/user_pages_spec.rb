require 'spec_helper'

describe "user_pages" do

	subject { page }

	describe "signup page GET /signup" do

		before { visit signup_path }

		it { should have_selector('h1', "Sign Up") }
		it { should have_title(full_title("Sign Up")) }
	end
end
