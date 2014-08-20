class EngagementsController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user, only: [:show]

  def new
  	@engagement = Engagement.new
  end

  def create
  	@engagement = current_user.engagements.build(engagement_params)
  	if @engagement.save
  		current_user.activities.create(
  			title: @engagement.title,
  			path: engagement_path(@engagement),
  			category: "Doing more activities that truly engage you")
			flash[:success] = "Engagement experience tracked: #{@engagement.title}"
			redirect_to root_url
		else
			render 'new'
		end
  end

  def show
  	@engagement = Engagement.find(params[:id])
  end

  private

  	def engagement_params
  		params.fetch(:engagement, Hash.new).permit(:title, :content, :photo)
  	end

  	def correct_user
  		@engagement = current_user.engagements.find_by_id(params[:id])
  		if @engagement.nil? && !current_user.try(:admin)
  			redirect_to root_url
  		end
  	end
end
