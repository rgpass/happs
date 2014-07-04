require 'spec_helper'

describe UsersHelper do
  before { @user = User.new(first_name: "Ben", last_name: "Dover",
                            email: "ben.dover@gmail.com",
                            password: "foobar",
                            password_confirmation: "foobar") }

  describe "full_name" do
    it "returns user's first and last name" do
      expect(full_name(@user)).to eq("Ben Dover")
    end
  end
end
