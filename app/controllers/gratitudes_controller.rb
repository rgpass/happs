class GratitudesController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user, only: [:show]

	def new
		@gratitude = Gratitude.new
	end

	def create
		@gratitude = current_user.gratitudes.build(gratitude_params)
		if @gratitude.save
			current_user.activities.create(
				title: @gratitude.title, 
				path: gratitude_path(@gratitude), category: "Expressing gratitude")
			flash[:success] = "Gratitude tracked: #{@gratitude.title}"
			redirect_to current_user
		else
			render 'new'
		end
	end

	def show
		@gratitude = Gratitude.find(params[:id])
	end

	private

		def gratitude_params
			params.fetch(:gratitude, Hash.new).permit(:title, :content)
		end

		def correct_user
			@gratitude = current_user.gratitudes.find_by_id(params[:id])
			if @gratitude.nil? && !current_user.try(:admin)
				redirect_to root_url
			end
		end
end
