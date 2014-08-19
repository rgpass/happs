require "spec_helper"

describe "kindness_pages" do

	subject { page }

	describe "new kindness GET /kindnesses/new" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_kindness_path
		end

		it { should have_title("Practice Acts of Kindness") }
		it { should have_selector("h1", "Acts of Kindness") }

		describe "create kindness POST /kindnesses" do
			describe "valid information" do
				let(:submit) { "All Done" }

				before do
					fill_in 'kindness_title', with: "Helped an old lady"
					fill_in 'kindness_content', with: "Walked her across the street"
				end

				it "creates user.kindness" do
					expect { click_button submit }.to change(user.kindnesses, :count).by(1)
				end

				describe "after submission" do
					before { click_button submit }

					it { should have_title(full_name(user)) }
					it { should have_selector('div.alert.alert-success',
						text: "Kindness tracked: Helped an old lady") }
					it { should have_content("Practicing acts of kindness") }
				end
			end

			describe "invalid information" do
				let(:submit) { "All Done" }

				it "does not create kindness" do
					expect { click_button submit }.not_to change(user.kindnesses, :count)
				end

				describe "after submission" do
					before { click_button submit }

					it { should have_title("Practice Acts of Kindness") }
					it { should have_content("error") }
				end
			end
		end
	end
end
