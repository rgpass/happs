class User < ActiveRecord::Base
	has_many :subjective_happiness_scales, dependent: :destroy
	has_many :activities, dependent: :destroy
	has_many :ohqs, dependent: :destroy
	has_one	 :pafd, dependent: :destroy
	has_many :gratitudes, dependent: :destroy
	has_many :joys, dependent: :destroy
	has_many :kindnesses, dependent: :destroy
	has_many :engagements, dependent: :destroy

	before_save { email.downcase! }
	before_create :create_remember_token

	validates :first_name, presence: true, length: { maximum: 20 }
	validates :last_name,	 presence: true, length: { maximum: 30 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email,	presence: true, format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
