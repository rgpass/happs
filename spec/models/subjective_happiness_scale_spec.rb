require 'spec_helper'

# general:integer peers:integer regardless:integer neg:integer score:decimal
# user_id:integer
describe SubjectiveHappinessScale do
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@subjective_happiness_scale = user.subjective_happiness_scales.build(
	  	general: 6, peers: 6, regardless: 6, neg: 7)
  end

  subject { @subjective_happiness_scale }

  it { should respond_to(:general) }
  it { should respond_to(:peers) }
  it { should respond_to(:regardless) }
  it { should respond_to(:neg) }
  it { should respond_to(:score) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id not present" do
  	before { @subjective_happiness_scale.user_id = nil }
    it { should_not be_valid }
  end

  describe "when answer blank" do
  	it "general" do
	  	@subjective_happiness_scale.general = nil
	  	expect(@subjective_happiness_scale).not_to be_valid
	  end

	  it "peers" do
	  	@subjective_happiness_scale.peers = nil
	  	expect(@subjective_happiness_scale).not_to be_valid
	  end

	  it "regardless" do
	  	@subjective_happiness_scale.regardless = nil
	  	expect(@subjective_happiness_scale).not_to be_valid
	  end

	  it "neg" do
	  	@subjective_happiness_scale.neg = nil
	  	expect(@subjective_happiness_scale).not_to be_valid
	  end
  end

  describe "score" do
		before { @subjective_happiness_scale.save }
		its(:score) { should_not be_blank }

		it "equals average of inputs" do
			expect(@subjective_happiness_scale.score).to eq(6.25)
		end
  end

  describe "#average_score" do
	  before do
	  	@new_shs = user.subjective_happiness_scales.build(
		  	general: 5, peers: 6, regardless: 3, neg: 7)
	  	@new_shs.save
	  end

	  it "equals average of scores" do
	  	expect(user.subjective_happiness_scales.average_score).to eq(5.25)
	  end
  end
end
