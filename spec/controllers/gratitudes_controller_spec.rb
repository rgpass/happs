require 'spec_helper'

describe GratitudesController do
	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user, no_capybara: true }

	describe "GET new" do
		it "assigns a new Gratitude to @gratitude" do
			get :new
			assigns(:gratitude).should be_a_new(Gratitude)
		end

		it "renders :new" do
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		describe "with valid attributes" do
			it "creates new gratitude" do
				expect{
					post :create, gratitude: FactoryGirl.attributes_for(:gratitude)
				}.to change(Gratitude, :count).by(1)
			end

			it "creates new activity" do
				expect{
					post :create, gratitude: FactoryGirl.attributes_for(:gratitude)
				}.to change(Activity, :count).by(1)
			end

			it "redirects to root" do
				post :create, gratitude: FactoryGirl.attributes_for(:gratitude)
				expect(response).to redirect_to(root_url)
			end
		end

		describe "with invalid attributes" do
			it "does not create new gratitude" do
				expect{
					post :create, gratitude: FactoryGirl.attributes_for(:gratitude, title: " ")
				}.to_not change(Gratitude, :count)
			end

			it "does not create new activity" do
				expect{
					post :create, gratitude: FactoryGirl.attributes_for(:gratitude, title: " ")
				}.to_not change(Activity, :count)
			end

			it "re-renders :new" do
				post :create, gratitude: FactoryGirl.attributes_for(:gratitude, title: " ")
				expect(response).to render_template(:new)
			end
		end
	end

	describe "GET show" do
		let(:gratitude) { FactoryGirl.create(:gratitude, user: user) }

		it "assigns requested gratitude to @gratitude" do
			get :show, id: gratitude
			assigns(:gratitude).should eq(gratitude)
		end

		it "renders :show" do
			get :show, id: gratitude
			expect(response).to render_template("show")
		end
	end
end
