class JoysController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user, only: [:show]

  def new
  	@joy = Joy.new
  end

  def create
  	@joy = current_user.joys.build(joy_params)
  	if @joy.save
  		current_user.activities.create(
  			title: @joy.title,
  			path: joy_path(@joy), category: "Savoring life's joys")
			flash[:success] = "Joy tracked: #{@joy.title}"
			redirect_to root_url
		else
			render 'new'
		end
  end

  def show
  	@joy = Joy.find(params[:id])
  end

  private

  	def joy_params
  		params.fetch(:joy, Hash.new).permit(:title, :content, :photo)
  	end

  	def correct_user
  		@joy = current_user.joys.find_by_id(params[:id])
  		if @joy.nil? && !current_user.try(:admin)
  			redirect_to root_url
  		end
  	end
end
