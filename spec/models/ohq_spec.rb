require 'spec_helper'

describe Ohq do
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@ohq = user.ohqs.build(score: 87)
  end

  subject { @ohq }

  it { should respond_to(:score) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id not present" do
  	before { @ohq.user_id = nil }
  	it { should_not be_valid }
  end

  describe "when score not present" do
  	before { @ohq.save }

  	its(:score) { should_not be_blank }
  end

	before do
		user.ohqs.create(score: 80)
		user.ohqs.create(score: 100)
		user.ohqs.create(score: 90)
	end

  describe "#average_score" do
  	it "equals average of scores" do
  		expect(user.ohqs.average_score).to eq(90)
  	end
  end

  describe "#high_score" do
  	it "equals highest score" do
  		expect(user.ohqs.high_score).to eq(100)
  	end
  end

  describe "#initial_score" do
  	it "equals initial score" do
  		expect(user.ohqs.initial_score).to eq(80)
  	end
  end
end
