class KindnessesController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user, only: [:show]

  def new
  	@kindness = Kindness.new
  end

  def create
  	@kindness = current_user.kindnesses.build(kindness_params)
  	if @kindness.save
  		current_user.activities.create(
  			title: @kindness.title,
  			path: kindness_path(@kindness), category: "Practicing acts of kindness")
			flash[:success] = "Kindness tracked: #{@kindness.title}"
			redirect_to root_url
		else
			render 'new'
		end
  end

  def show
  	@kindness = Kindness.find(params[:id])
  end

  	def kindness_params
  		params.fetch(:kindness, Hash.new).permit(:title, :content, :photo)
  	end

  	def correct_user
  		@kindness = current_user.kindnesses.find_by_id(params[:id])
  		if @kindness.nil? && !current_user.try(:admin)
  			redirect_to root_url
  		end
  	end
end
