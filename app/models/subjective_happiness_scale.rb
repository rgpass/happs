class SubjectiveHappinessScale < ActiveRecord::Base
	belongs_to :user

	before_create :save_score 

	validates :user_id, presence: true
	validates :general, presence: true
	validates :peers,		presence: true
	validates :regardless, presence: true
	validates :neg,			presence: true

	default_scope -> { order('created_at DESC') }

	def self.average_score
		average(:score).to_f
	end

	private

		def save_score
			self.score = (general.to_f + peers.to_f + regardless.to_f + neg.to_f)/4
		end
end
