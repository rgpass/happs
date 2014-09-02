require 'spec_helper'

describe SessionsController do
	let(:user) { FactoryGirl.create(:user) }

	describe "GET new" do
		it "renders :new" do
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		describe "valid information" do
			it "signs in user" do
				post :create, session: { email: user.email, password: user.password }
				controller.should be_signed_in
			end

			it "redirects to user" do
				post :create, session: { email: user.email, password: user.password }
				expect(response).to redirect_to(root_url)
			end
		end

		describe "invalid information" do
			it "does not sign in user" do
				post :create, session: { email: "blah" }
				controller.should_not be_signed_in
			end

			it "re-renders :new" do
				post :create, session: { email: "blah" }
				expect(response).to render_template(:new)
			end
		end
	end

	describe "DELETE destroy" do
		before { sign_in user, no_capybara: true }

    it "destroys the requested session" do
      delete :destroy
      controller.should_not be_signed_in
    end

    it "redirects to the clients list" do
      delete :destroy
      controller.should redirect_to(root_url)
    end
	end
end
