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

		pending "Uncomment if you want to test posting"
		# describe "create ohq POST /ohqs" do
		# 	describe "valid information" do
		# 		before do
		# 			choose('ohq_q1_6')
		# 			choose('ohq_q2_6')
		# 			choose('ohq_q3_6')
		# 			choose('ohq_q4_6')
		# 			choose('ohq_q5_6')
		# 			choose('ohq_q6_6')
		# 			choose('ohq_q7_6')
		# 			choose('ohq_q8_6')
		# 			choose('ohq_q9_6')
		# 			choose('ohq_q10_6')
		# 			choose('ohq_q11_6')
		# 			choose('ohq_q12_6')
		# 			choose('ohq_q13_6')
		# 			choose('ohq_q14_6')
		# 			choose('ohq_q15_6')
		# 			choose('ohq_q16_6')
		# 			choose('ohq_q17_6')
		# 			choose('ohq_q18_6')
		# 			choose('ohq_q19_6')
		# 			choose('ohq_q20_6')
		# 			choose('ohq_q21_6')
		# 			choose('ohq_q22_6')
		# 			choose('ohq_q23_6')
		# 			choose('ohq_q24_6')
		# 			choose('ohq_q25_6')
		# 			choose('ohq_q26_6')
		# 			choose('ohq_q27_6')
		# 			choose('ohq_q28_6')
		# 			choose('ohq_q29_6')
		# 		end

		# 		let(:submit) { "All Done" }

		# 		it "creates user.ohq" do
		# 			expect { click_button submit }.to change(user.ohqs, :count).by(1)
		# 		end

		# 		describe "after submission" do
		# 			before { click_button submit }

		# 			it { should have_title(full_name(user)) }
		# 			it { should have_selector('div.alert.alert-success',
		# 				text: 'Happiness tracked!') }
		# 			it { should have_content("100") }
		# 		end
		# 	end
		# end
	end
end
