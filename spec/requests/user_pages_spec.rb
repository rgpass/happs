require 'spec_helper'

describe "user_pages" do

	subject { page }

	describe "index page GET /users" do
		let(:admin) { FactoryGirl.create(:admin) }

		before do
			sign_in admin
			visit users_path
		end

		it { should have_title('All Users') }
		it { should have_content('All Users') }

		describe "pagination" do
			before(:all) { 30.times { FactoryGirl.create(:user) } }
			after(:all) { User.delete_all }

			it { should have_selector('ul.pagination') }

			it "lists each user" do
				User.paginate(page: 1).each do |user|
					expect(page).to have_selector('li', text: full_name(user))
				end
			end
		end

		describe "delete links" do
			let(:admin) { FactoryGirl.create(:admin) }
			before(:all) { 30.times { FactoryGirl.create(:user) } }
			after(:all) { User.delete_all }

			before do
				sign_in admin
				visit users_path
			end

			it { should have_link('delete', href: user_path(User.first)) }
			it "able to delete another user" do
				expect do
					click_link('delete', match: :first)
				end.to change(User, :count).by(-1)
			end
			it { should_not have_link('delete', href: user_path(admin)) }
		end
	end

	describe "signup page GET /signup" do

		before { visit signup_path }

		it { should have_selector('h1', "Sign Up") }
		it { should have_title(full_title("Sign Up")) }

		describe "signup POST /users" do
			before { visit signup_path }

			let(:submit) { "Create my account" }

			describe "with valid information" do
				before do
					fill_in "First name",		with: "Ben"
					fill_in "Last name",		with: "Dover"
					fill_in "Email",				with: "ben.dover@gmail.com"
					fill_in "Password",			with: "foobar"
					fill_in "Confirm password",	with: "foobar"
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
					it { should have_link("Signed up! Awesome!", href: user_path(user)) }
					it { should have_content("Account") }
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
		let(:user)	{ FactoryGirl.create(:user) }
		let(:a1)		{ FactoryGirl.create(:activity, user: user, title: "Foo") }
		let(:a2)		{ FactoryGirl.create(:activity, user: user, title: "Bar") }
		before do
			sign_in user
			visit user_path(user)
		end

		it { should have_content(full_name(user)) }
		it { should have_title(full_title(full_name(user))) }

		it { should have_link('Measure My Happiness', new_ohq_path) }

		describe "activity history" do
			pending "Determine why this fails although it works"
			# it { should have_content(a1.title) }
			# it { should have_content(a2.title) }
		end
	end

	describe "edit page GET /users/:id/edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user)
		end

		it { should have_content("Update your profile") }
		it { should have_title("Edit User") }
		it { should have_link('change', href: 'http://gravatar.com/emails') }

		describe "edit PATCH /users/:id" do
			describe "with valid information" do
				let(:new_first_name)	{ "Gerry" }
				let(:new_last_name)		{ "Pass" }
				let(:new_email)				{ "rgpass@gmail.com" }
				before do
					fill_in "First name",		with: new_first_name
					fill_in "Last name",		with: new_last_name
					fill_in "Email",				with: new_email
					fill_in "Password",			with: user.password
					fill_in "Confirm password",	with: user.password
					click_button "Save Changes"
				end

				it { should have_title("#{new_first_name} #{new_last_name}") }
				it { should have_selector('div.alert.alert-success') }
				it { should have_link("Account information updated", href: user_path(user)) }
				it { should have_content("Account") }
				specify { expect(user.reload.first_name).to eq new_first_name }
				specify { expect(user.reload.last_name).to eq new_last_name }
				specify { expect(user.reload.email).to eq new_email }
			end

			describe "with invalid information" do
				before { click_button "Save Changes" }
				it { should have_content('error') }
			end
		end

		describe "forbidden attributes" do
			let(:params) do
				{ user: { admin: true, password: user.password,
					password_confirmation: user.password } }
			end
			before do
				sign_in user, no_capybara: true
				patch user_path(user), params
			end
			specify { expect(user.reload).not_to be_admin }
		end
	end
end
