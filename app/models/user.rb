class User < ActiveRecord::Base
	has_secure_password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	before_save { self.email = email.downcase }

	validates :firstN, :lastN, presence: true, length: {minimum: 2, maximum: 64}
	validates :email, presence: true, uniqueness: true
	validates_format_of :email, with: VALID_EMAIL_REGEX, :on => :create

	#vaildates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
	#validates_confirmation_of :password, allow_blank: true

	validates :password, presence: true, confirmation: true, length: {minimum: 8, maximum: 64}, :on => :create
	validates :password_confirmation, presence: true
	
	validates :mobile_phone, format: { with: /\d{3}\d{3}\d{4}/, message: "is invalid" }

end
