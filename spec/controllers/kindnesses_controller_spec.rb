require 'spec_helper'

describe KindnessesController do
	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user, no_capybara: true }

	describe "GET new" do
		it "assigns a new Kindness to @kindness" do
			get :new
			assigns(:kindness).should be_a_new(Kindness)
		end

		it "renders :new" do
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		describe "with valid attributes" do
			it "creates new kindness" do
				expect{
					post :create, kindness: FactoryGirl.attributes_for(:kindness)
				}.to change(Kindness, :count).by(1)
			end

			it "creates new activity" do
				expect{
					post :create, kindness: FactoryGirl.attributes_for(:kindness)
				}.to change(Activity, :count).by(1)
			end

			it "redirects to root" do
				post :create, kindness: FactoryGirl.attributes_for(:kindness)
				expect(response).to redirect_to(root_url)
			end
		end

		describe "with invalid attributes" do
			it "does not create new kindness" do
				expect{
					post :create, kindness: FactoryGirl.attributes_for(:kindness, title: " ")
				}.to_not change(Kindness, :count)
			end

			it "does not create new activity" do
				expect{
					post :create, kindness: FactoryGirl.attributes_for(:kindness, title: " ")
				}.to_not change(Activity, :count)
			end

			it "re-renders :new" do
				post :create, kindness: FactoryGirl.attributes_for(:kindness, title: " ")
				expect(response).to render_template(:new)
			end
		end
	end

	describe "GET show" do
		let(:kindness) { FactoryGirl.create(:kindness, user: user) }

		it "assigns requested kindness to @kindness" do
			get :show, id: kindness
			assigns(:kindness).should eq(kindness)
		end

		it "renders :show" do
			get :show, id: kindness
			expect(response).to render_template("show")
		end
	end
end
