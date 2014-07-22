class Activity < ActiveRecord::Base
	belongs_to :user

	validates :user_id,		presence: true
	validates :title,			presence: true, length: { maximum: 40 }
	validates :category,	presence: true

	default_scope -> { order('created_at DESC') }
end
