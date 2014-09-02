require 'spec_helper'

describe "gratitude_pages" do

	subject { page }

	describe "new gratitude GET /gratitudes/new" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_gratitude_path
		end

		it { should have_title("Express Gratitude") }
		it { should have_selector("h1", "Gratitude") }

		describe "create gratitude POST /gratitudes" do
			describe "valid information" do
				let(:submit) { "All Done" }

				before do
					fill_in 'gratitude_title', with: "Lamp"
					fill_in 'gratitude_content', with: "I love lamp"
				end

				it "creates user.gratitude" do
					expect { click_button submit }.to change(user.gratitudes, :count).by(1)
				end

				describe "after submission" do
					before { click_button submit }

					it { should have_title(full_name(user)) }
					it { should have_selector('div.alert.alert-success',
						text: "Gratitude tracked: Lamp") }
					it { should have_content("Expressing gratitude") }
				end
			end

			describe "invalid information" do
				let(:submit) { "All Done" }

				it "does not create gratitude" do
					expect { click_button submit }.not_to change(user.gratitudes, :count)
				end

				describe "after submission" do
					before { click_button submit }

					it { should have_title("Express Gratitude") }
					it { should have_content("error") }
				end
			end
		end
	end

	it_should_behave_like "show activity", "gratitude"
end
