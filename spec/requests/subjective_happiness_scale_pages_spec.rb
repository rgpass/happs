require 'spec_helper'

describe "subjective_happiness_scale_pages" do
	
	subject { page }

  describe "new shs GET /subjective_happiness_scale/new" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_subjective_happiness_scale_path
		end

		it { should have_title("Subjective Happiness Scale") }
		it { should have_selector("h1", "Subjective Happiness Scale") }

		describe "last one taken <2wks ago" do
			let!(:shs) { FactoryGirl.create(:subjective_happiness_scale,
				user: user, created_at: Time.now) }
			before do
				sign_in user
				visit new_subjective_happiness_scale_path
			end

			it { should have_selector('div.alert.alert-warning',
				text: "It's been under two weeks since") }
		end

		describe ">=3 taken" do
			let!(:shs) { FactoryGirl.create(:subjective_happiness_scale,
				user: user, created_at: Time.now) }
			let!(:shs2) { FactoryGirl.create(:subjective_happiness_scale,
				user: user, created_at: Time.now) }
			let!(:shs3) { FactoryGirl.create(:subjective_happiness_scale,
				user: user, created_at: Time.now) }
			before do
				sign_in user
				visit new_subjective_happiness_scale_path
			end

			it { should have_selector('div.alert.alert-danger',
				text: 'Taking more than 3 can skew results!') }
		end

		describe "create shs POST /subjective_happiness_scale" do

			before { visit new_subjective_happiness_scale_path }

			let(:submit) { "All done" }

			describe "valid information" do
				before do
					choose('subjective_happiness_scale_general_6')
					choose('subjective_happiness_scale_peers_7')
					choose('subjective_happiness_scale_regardless_6')
					choose('subjective_happiness_scale_neg_7')
				end

				it "creates shs" do
					expect { click_button submit }.to change(SubjectiveHappinessScale, 
						:count).by(1)
				end

				it "creates user.shs" do
					expect { click_button submit }.to change(
						user.subjective_happiness_scales, :count).by(1)
				end

				describe "after submission" do
					pending "Figure out what to do with SHS"
				end
			end

			describe "invalid information" do
				it "does not create shs" do
					expect { click_button submit }.not_to change(
						SubjectiveHappinessScale, :count)
				end

				describe "after submission" do
					before { click_button submit }

					it { should have_title("Subjective Happiness Scale") }
					it { should have_content("error") }
				end

				describe "at least one answered" do
					before do
						choose('subjective_happiness_scale_general_6')
						click_button submit
					end

					it { should have_title("Subjective Happiness Scale") }
					it { should have_content("error") }
				end
			end
		end
  end
end
