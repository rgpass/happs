require "spec_helper"

describe "engagement_pages" do

	subject { page }

	describe "new engagement GET /engagements/new" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_engagement_path
		end

		it { should have_title("Engage Yourself") }
		it { should have_selector("h1", "Engage Yourself") }

		describe "create engagement POST /engagements" do
			describe "valid information" do
				let(:submit) { "All Done" }

				before do
					fill_in 'engagement_title', with: "Coding"
					fill_in 'engagement_content', with: "Got in the zone with coding"
				end

				it "creates user.engagement" do
					expect { click_button submit }.to change(user.engagements, :count).by(1)
				end

				describe "after submission" do
					before { click_button submit }

					it { should have_title(full_name(user)) }
					it { should have_selector('div.alert.alert-success',
						text: "Engagement experience tracked: Coding") }
					it { should have_content("Doing more activities that truly engage you") }
				end
			end

			describe "invalid information" do
				let(:submit) { "All Done" }

				it "does not create engagement" do
					expect { click_button submit }.not_to change(user.engagements, :count)
				end

				describe "after submission" do
					before { click_button submit }

					it { should have_title("Engage Yourself") }
					it { should have_content("error") }
				end
			end
		end
	end

	it_should_behave_like "show activity", "engagement"
end
