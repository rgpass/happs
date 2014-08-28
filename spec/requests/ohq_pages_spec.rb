require 'spec_helper'

describe "ohq_pages" do

	subject { page }

	describe "new ohq GET /ohqs/new" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_ohq_path
		end

		it { should have_title("Quantify Happiness") }
		it { should have_selector("h1", "Oxford Happiness Questionnaire") }

		describe "invalid information" do
			it { should have_css(".btn.btn-primary[disabled]") }
			it { should_not have_content("All Done") }
		end
	end
end
