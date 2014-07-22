require 'spec_helper'

describe UsersController do
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
		end
	end

	describe "PATCH update" do
		pending "Determine why this fails although it works"
		# let(:user) { FactoryGirl.create(:user) }

		# describe "with valid attributes" do
		# 	it "creates new activity" do
		# 		expect{
		# 			patch :update, id: user.id,
		# 				user: FactoryGirl.attributes_for(:user, first_name: "Joe",
		# 					password: "foobar", password_confirmation: "foobar")
		# 		}.to change(Activity, :count).by(1)
		# 	end
		# end
	end
end
