require 'spec_helper'

describe EngagementsController do
	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user, no_capybara: true }

	describe "GET new" do
		it "assigns a new Engagement to @engagement" do
			get :new
			assigns(:engagement).should be_a_new(Engagement)
		end

		it "renders :new" do
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		describe "with valid attributes" do
			it "creates new engagement" do
				expect{
					post :create, engagement: FactoryGirl.attributes_for(:engagement)
				}.to change(Engagement, :count).by(1)
			end

			it "creates new activity" do
				expect{
					post :create, engagement: FactoryGirl.attributes_for(:engagement)
				}.to change(Activity, :count).by(1)
			end

			it "redirects to root" do
				post :create, engagement: FactoryGirl.attributes_for(:engagement)
				expect(response).to redirect_to(root_url)
			end
		end

		describe "with invalid attributes" do
			it "does not create new engagement" do
				expect{
					post :create, engagement: FactoryGirl.attributes_for(:engagement, title: " ")
				}.to_not change(Engagement, :count)
			end

			it "does not create new activity" do
				expect{
					post :create, engagement: FactoryGirl.attributes_for(:engagement, title: " ")
				}.to_not change(Activity, :count)
			end

			it "re-renders :new" do
				post :create, engagement: FactoryGirl.attributes_for(:engagement, title: " ")
				expect(response).to render_template(:new)
			end
		end
	end

	describe "GET show" do
		let(:engagement) { FactoryGirl.create(:engagement, user: user) }

		it "assigns requested engagement to @engagement" do
			get :show, id: engagement
			assigns(:engagement).should eq(engagement)
		end

		it "renders :show" do
			get :show, id: engagement
			expect(response).to render_template("show")
		end
	end
end
