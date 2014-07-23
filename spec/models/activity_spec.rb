require 'spec_helper'

describe Activity do
	let(:user) { FactoryGirl.create(:user) }
  before do
  	@activity = user.activities.build(title: "Sunset", path: "/gratitude/1",
  	category: "Gratitude")
  end

  subject { @activity }

  it { should respond_to(:title) }
  it { should respond_to(:path) }
  it { should respond_to(:category) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "user_id" do
  	describe "not present" do
  		before { @activity.user_id = nil }
  		it { should_not be_valid }
  	end
  end

  describe "title" do
  	describe "not present" do
  		before { @activity.title = " " }
  		it { should_not be_valid }
  	end

  	describe "too long" do
  		before { @activity.title = "a"*41 }
  		it { should_not be_valid }
  	end
  end

  describe "path" do
  	describe "not present" do
  		before { @activity.path = " " }
  		it { should be_valid }
  	end
  end

  describe "category" do
  	describe "not present" do
  		before { @activity.category = " " }
  		it { should_not be_valid }
  	end
  end
end
