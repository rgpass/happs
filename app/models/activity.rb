class Activity < ActiveRecord::Base
	belongs_to :user

	validates :user_id,		presence: true
	validates :title,			presence: true, length: { maximum: 40 }
	validates :category,	presence: true

	default_scope -> { order('created_at DESC') }

	def self.happiness_activity_count
		self.where("activities.category IN (?)", real_activities).count
	end

	def self.results_for_diagram
    results = []
    real_activities.each do |activity|
    	results << [activity, self.where(category: activity).count]
    end
    results.sort { |x,y| y[1] <=> x[1] }
	end

	private

		def self.real_activities
	    [
	    	"Expressing gratitude",
	    	"Savoring life's joys",
	    	"Practicing acts of kindness",
	    	"Doing more activities that truly engage you"
	    ]
		end
end
