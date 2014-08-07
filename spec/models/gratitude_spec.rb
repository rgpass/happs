require 'spec_helper'

describe Gratitude do
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@gratitude = user.gratitudes.new(title: "My wife",
  		content: "Because she's the bomb dot com", user: user)
  end

  subject { @gratitude }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "title not present" do
  	before { @gratitude.title = " " }
  	it { should_not be_valid }
  end

  describe "user_id not present" do
  	before { @gratitude.user_id = nil }
  	it { should_not be_valid }
  end
end
