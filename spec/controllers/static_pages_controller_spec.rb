require 'spec_helper'

describe StaticPagesController do
	describe "GET help" do
		it "renders :help" do
			get :help
			expect(response).to render_template(:help)
		end
	end

	describe "GET about" do
		it "renders :about" do
			get :about
			expect(response).to render_template(:about)
		end 
	end

	describe "GET research" do
		it "renders :research" do
			get :research
			expect(response).to render_template(:research)
		end
	end
end
