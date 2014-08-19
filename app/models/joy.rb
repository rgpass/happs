class Joy < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :user_id, :title

	has_attached_file :photo
	validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
	validates_with AttachmentSizeValidator, :attributes => :photo, :less_than => 3.megabytes

	before_create :sanitize_content

	private

		def sanitize_content
			# Needs to be cleaned up
			# http://stackoverflow.com/questions/7414267/strip-html-from-string-ruby-on-rails
			self.content = content ? ActionView::Base.full_sanitizer.sanitize(content) : ""
		end
end
