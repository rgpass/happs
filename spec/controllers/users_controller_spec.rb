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
end
