require 'spec_helper'

describe PafdsController do
	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user, no_capybara: true }

	describe "GET new" do
		it "assigns a new Pafd to @pafd" do
			get :new
			assigns(:pafd).should be_a_new(Pafd)
		end

		it "renders :new" do
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		it "creates new pafd" do
			expect{
				post :create, pafd: FactoryGirl.attributes_for(:pafd)
			}.to change(Pafd, :count).by(1)
		end

		it "creates new activity" do
			expect{
				post :create, pafd: FactoryGirl.attributes_for(:pafd)
			}.to change(Activity, :count).by(1)
		end

		it "redirects to root" do
			post :create, pafd: FactoryGirl.attributes_for(:pafd)
			expect(response).to redirect_to(root_url)
		end
	end
end
