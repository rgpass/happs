class SubjectiveHappinessScalesController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]
  before_action :shs_variables,  only: [:new, :create]


  def new
  	@shs = SubjectiveHappinessScale.new
  end

  def create
    @shs = current_user.subjective_happiness_scales.build(shs_params)
  	if @shs.save
      current_user.activities.create(
        title: "Subjective Happiness Scale completed",
        path: user_path(current_user), category: "SHS")
  		flash[:success] = "Subjective Happiness Scale complete!"
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  private

  	def shs_params
      params.fetch(:subjective_happiness_scale, Hash.new).permit(
  			:general, :peers, :regardless, :neg)
  	end

    def shs_variables
      @user = current_user
      @shscales = @user.subjective_happiness_scales
      @time = @shscales.empty? ? 4.weeks.ago : @shscales.first.created_at
    end

end
