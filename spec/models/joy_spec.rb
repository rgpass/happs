require 'spec_helper'

describe Joy do
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@joy = user.joys.new(title: "Eating ice cream",
  		content: "Ate a ridic amount of ice cream", user: user)
  end

  subject { @joy }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "title not present" do
  	before { @joy.title = " " }
  	it { should_not be_valid }
  end

  describe "user_id not present" do
  	before { @joy.user_id = nil }
  	it { should_not be_valid }
  end
end
