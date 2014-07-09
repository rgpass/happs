class SubjectiveHappinessScalesController < ApplicationController
  def new
  	@user = current_user
  	@shs = SubjectiveHappinessScale.new
  end

  def create
  	@user = current_user
  	@shs = SubjectiveHappinessScale.new(shs_params)
  	if @shs.save
  		flash[:success] = "Subjective Happiness Scale complete!"
  		redirect_to current_user
  	else
  		render 'new'
  	end
  end

  private

  	def shs_params
  		params.require(:subjective_happiness_scale).permit(
  			:general, :peers, :regardless, :neg)
  	end
end
