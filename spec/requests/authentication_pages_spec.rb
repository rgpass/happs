require 'spec_helper'

describe "authentication_pages" do

	subject { page }

  describe "signin page GET /signin" do
  	before { visit signin_path }

  	it { should have_title("Sign In") }
  	it { should have_selector('h1', "Sign In") }

  	describe "signin POST /sessions" do

  		describe "with valid information" do
  			let(:user) { FactoryGirl.create(:user) }
  			before do
  				fill_in "Email", 		with: user.email.upcase
  				fill_in "Password", with: user.password
  				click_button "Sign In"
  			end

  			it { should have_title(full_name(user)) }
  			it { should have_link('Profile', 			href: user_path(user)) }
  			it { should have_link('Sign Out',			href: signout_path) }
  			it { should_not have_link('Sign In',	href: signin_path) }
  			it { should_not have_link('Sign Up',	href: signup_path) }

  			describe "signout DELETE /signout" do
  				before { click_link "Sign Out" }
  				it { should have_link "Sign In" }
  			end
  		end

  		describe "with invalid information" do
	  		before { click_button "Sign In" }

	  		it { should have_title("Sign In") }
	  		it { should have_selector('div.alert.alert-danger') }

	  		describe "after visiting another page" do
	  			before do
	  				within ".header" do
	  					click_link "About"
	  				end
	  			end

	  			it { should_not have_selector('div.alert.alert-danger') }
	  		end
  		end
  	end
  end
end
