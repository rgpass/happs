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
        before { sign_in user }

  			it { should have_title(full_name(user)) }
  			it { should have_link('Profile', 			href: user_path(user)) }
        it { should have_link('Settings',     href: edit_user_path(user)) }
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

  describe "authorization" do
    describe "for non-signed in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protect page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign In"
        end

        describe "after signing in" do
          it "renders desired protected page" do
            expect(page).to have_title('Edit User')
          end
        end
      end

      describe "in Users controller" do
        describe "edit page GET /users/:id/edit" do
          before { visit edit_user_path(user) }
          it { should have_title("Sign In") }
        end

        describe "update action PATCH /users/:id" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "index page GET /users" do
          before { visit users_path }
          it { should have_title('Sign In') }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "edit page GET /users/:id/edit" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit User')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "update action PATCH /users/:id" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "delete user DELETE /users/:id" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end
