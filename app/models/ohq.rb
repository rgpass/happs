class Ohq < ActiveRecord::Base
	belongs_to :user

	validates :user_id, presence: true

	default_scope -> { order('created_at DESC') }

	def self.average_score
		average(:score).to_f
	end

	def self.high_score
		maximum(:score).to_f
	end

	def self.initial_score
		last.score
	end
end
