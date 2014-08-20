class Activity < ActiveRecord::Base
	belongs_to :user

	validates :user_id,		presence: true
	validates :title,			presence: true, length: { maximum: 40 }
	validates :category,	presence: true

	default_scope -> { order('created_at DESC') }

	def self.real_activities
		real = ["Expressing gratitude"]
		self.where("activities.category IN (?)", real)
	end

	def self.results_for_diagram
    real = [
    	"Expressing gratitude",
    	"Savoring life's joys",
    	"Practicing acts of kindness",
    	"Doing more activities that truly engage you"
    ]
    results = []
    real.each do |activity|
    	results << [activity, self.where(category: activity).count]
    end
    results.sort { |x,y| y[1] <=> x[1] }
	end
end
