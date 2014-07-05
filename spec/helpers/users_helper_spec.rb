require 'spec_helper'

describe UsersHelper do
	let(:user) { FactoryGirl.create(:user) }

  describe "full_name" do
    it "returns user's first and last name" do
      expect(full_name(user)).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end
