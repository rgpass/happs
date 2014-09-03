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

  describe "default scope" do
    let(:user2) { FactoryGirl.create(:user) }
    let(:older_ohq) { FactoryGirl.create(:ohq, score: 90, created_at: 2.weeks.ago, user: user2) }
    let(:newer_ohq) { FactoryGirl.create(:ohq, score: 100, created_at: 2.hours.ago, user: user2) }

    it "is descending by created_at" do
      expect(user2.ohqs).to eq([newer_ohq, older_ohq])
    end
  end

	before do
		user.ohqs.create(score: 80)
		user.ohqs.create(score: 100)
		user.ohqs.create(score: 90)
	end

  describe ".average_score" do
  	it "equals average of scores" do
  		expect(user.ohqs.average_score).to eq(90)
  	end
  end

  describe ".high_score" do
  	it "equals highest score" do
  		expect(user.ohqs.high_score).to eq(100)
  	end
  end

  describe ".initial_score" do
  	it "equals initial score" do
  		expect(user.ohqs.initial_score).to eq(80)
  	end
  end

  describe ".results_for_diagram" do
    before { Ohq.destroy_all }
    let(:ohq1) { FactoryGirl.create(:ohq, score: 80, user: user) }
    let(:ohq2) { FactoryGirl.create(:ohq, score: 85, user: user) }

    it "returns array of ohqs" do
      created_at1 = ohq1.created_at
      created_at2 = ohq2.created_at
      
      expected_result = [
        [created_at1.year, created_at1.month, created_at1.day, ohq1.score],
        [created_at2.year, created_at2.month, created_at2.day, ohq2.score],
      ]

      expect(user.ohqs.results_for_diagram).to eq(expected_result)
    end
  end
end
