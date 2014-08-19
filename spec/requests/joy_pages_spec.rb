require "spec_helper"

describe "joy_pages" do

	subject { page }

	describe "new joy GET /joys/new" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_joy_path
		end

		it { should have_title("Savor Life's Joys") }
		it { should have_selector("h1", "Savor Joy") }

		describe "create joy POST /joys" do
			describe "valid information" do
				let(:submit) { "All Done" }

				before do
					fill_in 'joy_title', with: "Ice cream"
					fill_in 'joy_content', with: "Ate a ridic amount of ice cream"
				end

				it "creates user.joy" do
					expect { click_button submit }.to change(user.joys, :count).by(1)
				end

				describe "after submission" do
					before { click_button submit }

					it { should have_title(full_name(user)) }
					it { should have_selector('div.alert.alert-success',
						text: "Joy tracked: Ice cream") }
					it { should have_content("Savoring life's joys") }
				end
			end

			describe "invalid information" do
				let(:submit) { "All Done" }

				it "does not create joy" do
					expect { click_button submit }.not_to change(user.joys, :count)
				end

				describe "after submission" do
					before { click_button submit }

					it { should have_title("Savor Life's Joys") }
					it { should have_content("error") }
				end
			end
		end
	end
end
