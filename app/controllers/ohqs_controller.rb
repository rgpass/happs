class OhqsController < ApplicationController
	before_action :signed_in_user

	def new
		@ohq = Ohq.new
	end

	def create
		@ohq = current_user.ohqs.build(ohq_params)
		if @ohq.save
			current_user.activities.create(
				title: "Happiness measured -- #{@ohq.score} / 100", 
				path: user_path(current_user), category: "Measured Happiness")
			flash[:success] = "Happiness tracked!"
			redirect_to root_path
		else
			render 'new'
		end
	end

	private

		def ohq_params
			params.fetch(:ohq, Hash.new).permit(
				:q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10,
				:q11, :q12, :q13, :q14, :q15, :q16, :q17, :q18, :q19, :q20,
				:q21, :q22, :q23, :q24, :q25, :q26, :q27, :q28, :q29)
		end
end
