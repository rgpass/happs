class Ohq < ActiveRecord::Base
	belongs_to :user

	validates :user_id, presence: true

	def self.average_score
		average(:score).to_f
	end

	def self.high_score
		maximum(:score).to_f
	end

	def self.initial_score
		first.score
	end
end
