require 'spec_helper'

describe JoysController do
	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user, no_capybara: true }

	describe "GET new" do
		it "assigns a new Joy to @joy" do
			get :new
			assigns(:joy).should be_a_new(Joy)
		end

		it "renders :new" do
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		describe "with valid attributes" do
			it "creates new joy" do
				expect{
					post :create, joy: FactoryGirl.attributes_for(:joy)
				}.to change(Joy, :count).by(1)
			end

			it "creates new activity" do
				expect{
					post :create, joy: FactoryGirl.attributes_for(:joy)
				}.to change(Activity, :count).by(1)
			end

			it "redirects to root" do
				post :create, joy: FactoryGirl.attributes_for(:joy)
				expect(response).to redirect_to(root_url)
			end
		end

		describe "with invalid attributes" do
			it "does not create new joy" do
				expect{
					post :create, joy: FactoryGirl.attributes_for(:joy, title: " ")
				}.to_not change(Joy, :count)
			end

			it "does not create new activity" do
				expect{
					post :create, joy: FactoryGirl.attributes_for(:joy, title: " ")
				}.to_not change(Activity, :count)
			end

			it "re-renders :new" do
				post :create, joy: FactoryGirl.attributes_for(:joy, title: " ")
				expect(response).to render_template(:new)
			end
		end
	end

	describe "GET show" do
		let(:joy) { FactoryGirl.create(:joy, user: user) }

		it "assigns requested joy to @joy" do
			get :show, id: joy
			assigns(:joy).should eq(joy)
		end

		it "renders :show" do
			get :show, id: joy
			expect(response).to render_template("show")
		end
	end
end
