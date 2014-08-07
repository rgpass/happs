class PafdsController < ApplicationController
	before_action :signed_in_user

  def new
  	@pafd = Pafd.new
  end

  def create
  	@pafd = current_user.build_pafd(pafd_params)
  	if @pafd.save
      current_user.activities.create(
        title: "Person-Activity Fit Diagnostic completed",
        path: user_path(current_user), category: "PAFD")
  		flash[:success] = "Person-Activity Fit Diagnositic completed!"
  		redirect_to current_user
  	else
  		render 'new'
  	end
  end

  private

  	def pafd_params
  		params.fetch(:pafd, Hash.new).permit(
  			:gratitude_n, :gratitude_e, :gratitude_v, :gratitude_g, :gratitude_s,
  			:optimism_n, :optimism_e, :optimism_v, :optimism_g, :optimism_s,
  			:comparison_n, :comparison_e, :comparison_v, :comparison_g, :comparison_s,
  			:kindness_n, :kindness_e, :kindness_v, :kindness_g, :kindness_s,
  			:relationships_n, :relationships_e, :relationships_v, :relationships_g, :relationships_s,
  			:coping_n, :coping_e, :coping_v, :coping_g, :coping_s,
  			:forgiveness_n, :forgiveness_e, :forgiveness_v, :forgiveness_g, :forgiveness_s,
  			:engagement_n, :engagement_e, :engagement_v, :engagement_g, :engagement_s,
  			:joys_n, :joys_e, :joys_v, :joys_g, :joys_s,
  			:goals_n, :goals_e, :goals_v, :goals_g, :goals_s,
  			:spirituality_n, :spirituality_e, :spirituality_v, :spirituality_g, :spirituality_s,
  			:body_n, :body_e, :body_v, :body_g, :body_s)
  	end
end
