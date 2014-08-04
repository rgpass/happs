require 'spec_helper'

describe Pafd do
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@pafd = user.build_pafd(gratitude: 4.17, optimism: 3, comparison: 2,
  		kindness: 3.5, relationships: 1.5, coping: 0.5, forgiveness: 0,
  		engagement: 3.5, joys: 3.83, goals: 2.17, spirituality: 2.67, body: 0.83)
  end

  subject { @pafd }

  it { should respond_to(:gratitude) }
  it { should respond_to(:optimism) }
  it { should respond_to(:comparison) }
  it { should respond_to(:kindness) }
  it { should respond_to(:relationships) }
  it { should respond_to(:coping) }
  it { should respond_to(:forgiveness) }
  it { should respond_to(:engagement) }
  it { should respond_to(:joys) }
  it { should respond_to(:goals) }
  it { should respond_to(:spirituality) }
  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  describe "when user_id not present" do
  	before { @pafd.user_id = nil }
  	it { should_not be_valid }
  end

  describe "when any score negative" do
		before do
			@pafd.forgiveness = -5.33
  		@pafd.save
  	end

  	it "converts it to 0" do
	  	expect(@pafd.forgiveness).to eq(0)
  	end
  end
end
