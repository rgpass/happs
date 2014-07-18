require 'spec_helper'

describe "static_pages" do

	subject { page }

	shared_examples_for "all static pages" do
		it { should have_selector('h1', text: heading) }
		it { should have_title(full_title(page_title)) }
	end

	describe "home page GET /" do
		before { visit root_path }
		let(:heading)			{ "Happs" }
		let(:page_title)	{ "" }

		it_should_behave_like "all static pages"
		it { should_not have_title("| Home") }
	end

	describe "help page GET /help" do
		before { visit help_path }
		let(:heading)			{ "Help" }
		let(:page_title)	{ "Help" }		

		it_should_behave_like "all static pages"
	end

	describe "about page GET /about" do
		before { visit about_path }
		let(:heading)			{ "About" }
		let(:page_title)	{ "About Us" }

		it_should_behave_like "all static pages"
	end

	describe "research page GET /research" do
		before { visit research_path }
		let(:heading)			{ "The Research" }
		let(:page_title)	{ "Research" }

		it_should_behave_like "all static pages"
	end

	it "has correct links in header" do
		visit root_path
		within ".header" do
			click_link "About"
			expect(page).to have_title(full_title("About Us"))
			click_link "Research"
			expect(page).to have_title(full_title("Research"))
			click_link "Help"
			expect(page).to have_title(full_title("Help"))
			click_link "Sign Up"
			expect(page).to have_title(full_title("Sign Up"))
		end
	end

	it "has correct links in footer" do
		visit root_path
		within ".footer" do
			click_link "Home"
			expect(page).to have_title(full_title(''))
			click_link "About"
			expect(page).to have_title(full_title("About Us"))
			click_link "Research"
			expect(page).to have_title(full_title("Research"))
			click_link "Help"
			expect(page).to have_title(full_title("Help"))		
		end
	end
end
