class Ohq < ActiveRecord::Base
	attr_accessor :q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10
	attr_accessor :q11, :q12, :q13, :q14, :q15, :q16, :q17, :q18, :q19, :q20
	attr_accessor :q21, :q22, :q23, :q24, :q25, :q26, :q27, :q28, :q29

	belongs_to :user

	before_create :save_score

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

	private

		def save_score
			sum = [	q1.to_i, q2.to_i, q3.to_i, q4.to_i, q5.to_i, q6.to_i, q7.to_i, q8.to_i, q9.to_i, q10.to_i,
							q11.to_i, q12.to_i, q13.to_i, q14.to_i, q15.to_i, q16.to_i, q17.to_i, q18.to_i, q19.to_i, q20.to_i,
							q21.to_i, q22.to_i, q23.to_i, q24.to_i, q25.to_i, q26.to_i, q27.to_i, q28.to_i, q29.to_i].reduce(:+)
			average = sum / 29
			self.score ||= (average * 100 / 6).round # If score passed directly, ignore calculation
		end
end
