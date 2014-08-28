require "spec_helper"

describe "pafd_pages" do

	subject { page }

	describe "new pafd GET /pafds/new" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_pafd_path
		end

		it { should have_title("Person-Activity Fit") }
		it { should have_selector("h1", "Person-Activity Fit Diagnostic") }

		describe "invalid information" do
			it { should have_css(".btn.btn-primary[disabled]") }
			it { should_not have_content("All Done") }
		end
	end
end
