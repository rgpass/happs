class Pafd < ActiveRecord::Base
	attr_accessor :gratitude_n, :gratitude_e, :gratitude_v, :gratitude_g, :gratitude_s
	attr_accessor :optimism_n, :optimism_e, :optimism_v, :optimism_g, :optimism_s
	attr_accessor :comparison_n, :comparison_e, :comparison_v, :comparison_g, :comparison_s
	attr_accessor :kindness_n, :kindness_e, :kindness_v, :kindness_g, :kindness_s
	attr_accessor :relationships_n, :relationships_e, :relationships_v, :relationships_g, :relationships_s
	attr_accessor :coping_n, :coping_e, :coping_v, :coping_g, :coping_s
	attr_accessor :forgiveness_n, :forgiveness_e, :forgiveness_v, :forgiveness_g, :forgiveness_s
	attr_accessor :engagement_n, :engagement_e, :engagement_v, :engagement_g, :engagement_s
	attr_accessor :joys_n, :joys_e, :joys_v, :joys_g, :joys_s
	attr_accessor :goals_n, :goals_e, :goals_v, :goals_g, :goals_s
	attr_accessor :spirituality_n, :spirituality_e, :spirituality_v, :spirituality_g, :spirituality_s
	attr_accessor :body_n, :body_e, :body_v, :body_g, :body_s

	belongs_to :user

	validates_presence_of :user_id

	before_create :save_scores
	before_create :zero_out_negatives

	private

		def save_scores
			self.gratitude 			||= result("gratitude")
			self.optimism 		 	||= result("optimism")
			self.comparison 		||= result("comparison")
			self.kindness 			||= result("kindness")
			self.relationships 	||= result("relationships")
			self.coping 				||= result("coping")
			self.forgiveness 		||= result("forgiveness")
			self.engagement 		||= result("engagement")
			self.joys 					||= result("joys")
			self.goals 					||= result("goals")
			self.spirituality 	||= result("spirituality")
			self.body 					||= result("body")
		end

		def result(activity)
			activity_n = self.send("#{activity}_n")
			activity_e = self.send("#{activity}_e")
			activity_v = self.send("#{activity}_v")
			activity_g = self.send("#{activity}_g")
			activity_s = self.send("#{activity}_s")
			((activity_n.to_f + activity_e.to_f + activity_v.to_f)/3 - (activity_g.to_f + activity_s.to_f)/2).round(2)
		end

			# results 
			# gratitude_result =		(gratitude_n + gratitude_e + gratitude_v)/3 -
			# 											(gratitude_g + gratitude_s)/2
			# optimism_result =			(optimism_n + optimism_e + optimism_v)/3 -
			# 											(optimism_g + optimism_s)/2
			# comparison_result =		(comparison_n + comparison_e + comparison_v)/3 -
			# 											(comparison_g + comparison_s)/2
			# kindness_result =			(kindness_n + kindness_e + kindness_v)/3 -
			# 											(kindness_g + kindness_s)/2
			# relationships_result =	(relationships_n + relationships_e + relationships_v)/3 -
			# 												(relationships_g + relationships_s)/2
			# coping_result =				(coping_n + coping_e + coping_v)/3 -
			# 											(coping_g + coping_s)/2
			# forgiveness_result =	(forgiveness_n + forgiveness_e + forgiveness_v)/3 -
			# 											(forgiveness_g + forgiveness_s)/2
			# engagement_result =		(engagement_n + engagement_e + engagement_v)/3 -
			# 											(engagement_g + engagement_s)/2
			# joys_result =					(joys_n + joys_e + joys_v)/3 -
			# 											(joys_g + joys_s)/2
			# goals_result =				(goals_n + goals_e + goals_v)/3 -
			# 											(goals_g + goals_s)/2
			# spirituality_result =	(spirituality_n + spirituality_e + spirituality_v)/3 -
			# 											(spirituality_g + spirituality_s)/2
			# body_result =					(body_n + body_e + body_v)/3 -
			# 											(body_g + body_s)/2

		def zero_out_negatives
			activities = [:gratitude, :optimism, :comparison, :kindness, 
				:relationships, :coping, :forgiveness, :engagement, :joys, :goals, 
				:spirituality, :body]
			activities.each do |activity|
				activity_score = self.send("#{activity}")
				if activity_score < 0
					self.send("#{activity}=",0)
				end
			end
		end
end
