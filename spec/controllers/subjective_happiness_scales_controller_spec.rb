require 'spec_helper'

describe SubjectiveHappinessScalesController do
	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user, no_capybara: true }

	describe "GET new" do
		it "assigns a new SHS to @shs" do
			get :new
			assigns(:shs).should be_a_new(SubjectiveHappinessScale)
		end

		it "renders :new" do
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		describe "with valid attributes" do
			it "creates new shs" do
				expect{
					post :create, subjective_happiness_scale: FactoryGirl.attributes_for(:subjective_happiness_scale)
				}.to change(SubjectiveHappinessScale, :count).by(1)
			end

			it "creates new activity" do
				expect{
					post :create, subjective_happiness_scale: FactoryGirl.attributes_for(:subjective_happiness_scale)
				}.to change(Activity, :count).by(1)
			end

			it "redirects to root" do
				post :create, subjective_happiness_scale: FactoryGirl.attributes_for(:subjective_happiness_scale)
				expect(response).to redirect_to(root_url)
			end
		end

		describe "with invalid attributes" do
			it "does not create new shs" do
				expect{
					post :create, subjective_happiness_scale: FactoryGirl.attributes_for(:subjective_happiness_scale, general: nil)
				}.to_not change(SubjectiveHappinessScale, :count)
			end

			it "does not create new activity" do
				expect{
					post :create, subjective_happiness_scale: FactoryGirl.attributes_for(:subjective_happiness_scale, general: nil)
				}.to_not change(Activity, :count)
			end

			it "re-renders :new" do
				post :create, subjective_happiness_scale: FactoryGirl.attributes_for(:subjective_happiness_scale, general: nil)
				expect(response).to render_template(:new)
			end
		end
	end
end
