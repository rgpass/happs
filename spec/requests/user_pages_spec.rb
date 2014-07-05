require 'spec_helper'

describe "user_pages" do

	subject { page }

	describe "signup page GET /signup" do

		before { visit signup_path }

		it { should have_selector('h1', "Sign Up") }
		it { should have_title(full_title("Sign Up")) }

		describe "signup POST /users" do
			before { visit signup_path }

			let(:submit) { "Create my account" }

			describe "with valid information" do
				before do
					fill_in "First name", with: "Ben"
					fill_in "Last name", with: "Dover"
					fill_in "Email", with: "ben.dover@gmail.com"
					fill_in "Password", with: "foobar"
					fill_in "Confirmation", with: "foobar"
				end

				it "creates user" do
					expect { click_button submit }.to change(User, :count).by(1)
				end

				describe "after saving user" do
					before { click_button submit }
					let(:user) { User.find_by(email: "ben.dover@gmail.com") }

					it { should have_title(full_title(full_name(user))) }
					it { should have_selector('div.alert.alert-success', 
						text: 'Welcome') }
					it { should have_link('Sign Out') }
				end
			end

			describe "with invalid information" do
				it "does not create user" do
					expect { click_button submit }.not_to change(User, :count).by(1)
				end

				describe "after submission" do
					before { click_button submit }

					it { should have_title('Sign Up') }
					it { should have_content('error') }
				end
			end
		end
	end

	describe "show page GET /users/:id" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_content(full_name(user)) }
		it { should have_title(full_title(full_name(user))) }
	end
end
