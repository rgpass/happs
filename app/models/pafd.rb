class Pafd < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :user_id, :gratitude, :optimism, :comparison,
		:kindness, :relationships, :coping, :forgiveness, :engagement, :joys,
		:goals, :spirituality, :body

	before_create :zero_out_negatives

	private

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
