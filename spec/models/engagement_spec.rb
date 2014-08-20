require 'spec_helper'

describe Engagement do
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@engagement = user.engagements.new(title: "Coding",
  		content: "Got in the zone with coding", user: user)
  end

  subject { @engagement }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "title not present" do
  	before { @engagement.title = " " }
  	it { should_not be_valid }
  end

  describe "user_id not present" do
  	before { @engagement.user_id = nil }
  	it { should_not be_valid }
  end
end
