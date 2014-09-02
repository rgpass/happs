require 'spec_helper'

describe OhqsController do
	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user, no_capybara: true }

	describe "GET new" do
		it "assigns a new Ohq to @ohq" do
			get :new
			assigns(:ohq).should be_a_new(Ohq)
		end

		it "renders :new" do
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		it "creates new ohq" do
			expect{
				post :create, ohq: FactoryGirl.attributes_for(:ohq)
			}.to change(Ohq, :count).by(1)
		end

		it "creates new activity" do
			expect{
				post :create, ohq: FactoryGirl.attributes_for(:ohq)
			}.to change(Activity, :count).by(1)
		end

		it "redirects to root" do
			post :create, ohq: FactoryGirl.attributes_for(:ohq)
			expect(response).to redirect_to(root_url)
		end
	end
end
