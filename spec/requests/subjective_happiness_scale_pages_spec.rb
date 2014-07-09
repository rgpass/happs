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

		describe "create shs POST /subjective_happiness_scale" do
			pending "Also add logic so that only correct_user can visit new/create. Emulate user.rb for sol'n"
			pending "Add: link for new SHS in user show"

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
					before { click_button submit }

					it { should have_title(full_name(user)) }
					it { should have_selector('div.alert.alert-success', 
						text: 'Subjective Happiness Scale complete!') }
					it { should have_content(
						user.subjective_happiness_scales.average_score) }
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
