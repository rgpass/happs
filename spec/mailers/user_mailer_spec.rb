require "spec_helper"

describe UserMailer do
  describe "signup_confirmation" do
    let(:user) { FactoryGirl.create(:user) }
    let(:mail) { UserMailer.signup_confirmation(user) }

    it "renders the headers" do
      mail.subject.should eq("Welcome to Happs!")
      mail.to.should eq([user.email])
      mail.from.should eq(["gerry.pass@happs.io"])
    end

    it "renders the body" do
      mail.body.encoded.should match(user.first_name)
    end
  end

end
