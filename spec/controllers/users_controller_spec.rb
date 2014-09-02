require 'spec_helper'

describe UsersController do
	describe "GET index" do
		User.destroy_all
		let(:admin) { FactoryGirl.create(:admin) }
		before { sign_in admin, no_capybara: true }

		it "populates an array of users" do
			get :index
			assigns(:users).should eq([admin])
		end

		it "renders :index" do
			get :index
			expect(response).to render_template(:index)
		end
	end

	describe "GET new" do
		it "assigns a new User to @user" do
			get :new
			assigns(:user).should be_a_new(User)
		end

		it "renders :new" do
			get :new
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		describe "with valid attributes" do
			it "creates new user" do
				expect{
					post :create, user: FactoryGirl.attributes_for(:user)
				}.to change(User, :count).by(1)
			end

			it "creates new activity" do
				expect{
					post :create, user: FactoryGirl.attributes_for(:user)
				}.to change(Activity, :count).by(1)
			end

			it "sends confirmation email" do
				expect{
					post :create, user: FactoryGirl.attributes_for(:user)
				}.to change(ActionMailer::Base.deliveries, :count).by(1)
			end

			it "redirects to root" do
				post :create, user: FactoryGirl.attributes_for(:user)
				expect(response).to redirect_to(root_url)
			end
		end

		describe "with invalid attributes" do
			it "does not create new user" do
				expect{
					post :create, user: FactoryGirl.attributes_for(:user, email: " ")
				}.to_not change(User, :count)
			end

			it "does not create new activity" do
				expect{
					post :create, user: FactoryGirl.attributes_for(:user, email: " ")
				}.to_not change(Activity, :count)
			end

			it "does not send confirmation email" do
				expect{
					post :create, user: FactoryGirl.attributes_for(:user, email: " ")
				}.to_not change(ActionMailer::Base.deliveries, :count)
			end

			it "re-renders :new" do
				post :create, user: FactoryGirl.attributes_for(:user, email: " ")
				expect(response).to render_template(:new)
			end
		end
	end

	describe "GET edit" do
		let(:user) { FactoryGirl.create(:user) }
		before { sign_in user, no_capybara: true }

		it "assigns requested user to @user" do
			get :edit, id: user
			assigns(:user).should eq(user)
		end

		it "renders :edit" do
			get :edit, id: user
			expect(response).to render_template(:edit)
		end
	end

	describe "PUT update" do
		before :each do 
			@user = FactoryGirl.create(:user, first_name: "G")
			sign_in @user, no_capybara: true
		end

		describe "with valid attributes" do
			it "locates the requested @user" do
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: "Gerry")
				assigns(:user).should eq(@user)
			end

			it "changes @user's attributes" do
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: "Gerry")
				@user.reload
				@user.first_name.should eq("Gerry")
			end

			it "creates new activity" do
				expect{
					put :update, id: @user.id,
						user: FactoryGirl.attributes_for(:user, first_name: "Gerry")
				}.to change(Activity, :count).by(1)
			end

			it "redirects to root" do
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: "Gerry")
				expect(response).to redirect_to(root_url)
			end
		end

		describe "with invalid attributes" do
			it "locates the requested @user" do
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: " ")
				assigns(:user).should eq(@user)
			end

			it "does not change @user's attributes" do
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: " ")
				@user.reload
				@user.first_name.should eq("G")
			end

			it "does not create new activity" do
				expect{
					put :update, id: @user.id,
						user: FactoryGirl.attributes_for(:user, first_name: " ")
				}.to_not change(Activity, :count)
			end

			it "re-renders :edit" do
				put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: " ")
				expect(response).to render_template(:edit)
			end
		end
	end

	describe "GET show" do
		let(:user) { FactoryGirl.create(:user) }
		before { sign_in user, no_capybara: true }

		it "assigns requested user to @user" do
			get :show, id: user
			assigns(:user).should eq(user)
		end

		it "renders :show" do
			get :show, id: user
			expect(response).to render_template(:show)
		end
	end

	describe "DELETE destroy" do
		let(:user) { FactoryGirl.create(:user) }
		before { sign_in user, no_capybara: true }

		it "deletes the requested user" do
			expect{
				delete :destroy, id: user
			}.to change(User, :count).by(-1)
		end

		it "redirects to index" do
			delete :destroy, id: user
			expect(response).to redirect_to(users_url)
		end
	end

	describe "AJAX requests" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user, no_capybara: true
			@params = { user_id: user.id }
		end

		describe "GET ohq_data" do
			let!(:ohq) { FactoryGirl.create(:ohq, user: user) }

			it "returns OHQ data" do
				xhr :get, :ohq_data, @params
				parsed_body = JSON.parse(response.body)
				today = Time.now
				expected_ohq = [[today.year, today.month, today.day, ohq.score]]
				expect(parsed_body).to eq(expected_ohq)
			end
		end

		describe "GET pafd_data" do
			let!(:pafd) { FactoryGirl.create(:pafd, user: user) }

			it "returns PAFD data" do
				xhr :get, :pafd_data, @params
				parsed_body = JSON.parse(response.body)
				expect(parsed_body).to eq(pafd.results_for_diagram)
			end
		end

		describe "GET breakdown_data" do
			let!(:activity) { FactoryGirl.create(:activity, user: user) }

			it "returns breakdown data" do
				xhr :get, :breakdown_data, @params
				parsed_body = JSON.parse(response.body)
				expect(parsed_body).to eq(user.activities.results_for_diagram)
			end
		end
	end
end
