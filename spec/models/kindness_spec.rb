require 'spec_helper'

describe Kindness do
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@kindness = user.kindnesses.new(title: "Helped an old lady",
  		content: "She was crossing the street", user: user)
  end

  subject { @kindness }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "title not present" do
  	before { @kindness.title = " " }
  	it { should_not be_valid }
  end

  describe "user_id not present" do
  	before { @kindness.user_id = nil }
  	it { should_not be_valid }
  end
end
