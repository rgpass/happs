class GratitudesController < ApplicationController
	before_action :signed_in_user

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
end
